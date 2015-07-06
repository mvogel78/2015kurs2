#!/usr/bin/perl

use Image::Imgur;

my $key = "981e9afbf919858b1504214ad744e97c"; ## dev key imgur

my $imgur = Image::Imgur->new ({key => $key,
			      verbose => 1});

#print '$Foswiki::cfg{ImagePlugin}{AutoAttachExternalImages} = 1;\n';

#open U, "urls.txt";

#while(<U>){
#    chomp;
#    $bild
#}

open IN, "deducer.copy";
#open IN, "second/beforetesting.tex";
#open IN, "start/introduction2.tex";

open IMA, ">urls.txt";

$itlevel=0;
$tablevel=0;
$verblevel=0;

while(<IN>) {
    if (/^ *\\end{verbatim}/) {
	$verblevel--; 
	print "</verbatim>\n" 
    }
    if ($verblevel==1) {
	print $_;
	next;
    } 
    if (/^\%/) {next;}
    s/^ +//;
    s/\\sim/ ~/;
    s/\\_/_/;
    s/\\small//;
    s/\\large//;
    s/\\footnotesize//;
    s/\\normalsize//;
    s/\\tiny//;
    s/\\scriptsize//;
    s/\\\\[\w]*$//;
    s/\$\\mathtt{([A-z0-9()\., ]+)}\$/=$1=/g;
    s/\\emph{([A-z0-9()\., ]+)}/_$1_/g;
    s/\\texttt{([\/A-z0-9()\., =]+[^\w]*)}/$1/g;
    s/\\textbf{([A-z0-9()\., =]+[^\w]*)}/*$1*/g;
    if (/^ *\\begin{verbatim}/) { 
	$verblevel++;
	print "<verbatim>\n";
    }
    if ($verblevel==0) { 
	s/\|/&brvbar;/g;
	s/</&lt;/;
	s/>/&gt;/;
    }
    if ($verblevel==0 && $tablevel==0) { 
	s/ \${1,2}/ <latex> /g;
	s/([^\\])\${1,2}([ \.\,\n\r\t}])/$1<\/latex>$2/g;
    }
    if ($verblevel==0 && $tablevel==1) { 
	s/ \\sim / ~/g;
	s/ \${1,2}/ /g;
	s/([^\\])\${1,2}([ \.\,\n\r\t\|}])/$1 $2/g;
    }

     if (/^"/) { print $_ }
     if (/\\begin{itemize}/) { 
	$itlevel++;
	next;
     }
    if (/\\end{itemize}/) { 
	$itlevel--;
	next;
    }
    if (/\\begin{tabular}/) { 
	$tablevel++;
	next;
    }
    if (/\\end{tabular}/) { 
	$tablevel--;
	next;
    }
    if (/\\item[\[ ](.*)/) { 
	print "   " x $itlevel;
	print "* " . $1 . "\n";
	next;
    }
    if($tablevel){
	s/\&([^l^g^b])/\|$1/g;
	s/\$//g;
	s/ +/\ /g;
	if(/^[^\\]/){
	    chomp;
	    print "|" . $_ . "|\n" ;
	}
    }
    if (/^\\title{(.*)}/) { $title = "---+ " . $1 }
    if (/^\\titlepage/){ print "$title\n%TOC%\n\n%SLIDESHOWSTART%\n"}
    if (/^\\begin{frame}(.*)*\\frametitle{(.*)}/) { 
	$tmp = $2;
	$tmp =~ s/\\texttt{//;
	$tmp =~ s/}//;
	print "---++ " . $2 . "\n";
    }
    if (/includegraphics.*{(.*)\.p[ngdf]{2}}/){
	my $bild = $1 . ".png";
#	print "hallo $bild";
	my $url1 = $imgur->upload($bild) or die "upload failed";
#	print "<a href= '$url1'><img alt='" . $1 . "' src='". $url1 ."' width='350'/></a>\n";
	print "[[$url1][<img alt='" . $1 . "' src='". $url1 ."' width='350'/>]]\n";
#	print '%IMAGE{' . $url1 . '}%';
#	print "[[<img alt='" . $1 . "' src='". $url1 ."'/>][<img alt='" . $1 . "' src='". $url1 ."' width='50' />]]\n";
#	print IMA $bild . "|" . $url1 . "\n";
    }
    if ((/^[A-z0-9\+>^\\\[]+ /) && !($tablevel) ) { 
	print $_; 
    }
}