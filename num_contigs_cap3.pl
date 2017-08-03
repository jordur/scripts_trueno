#! usr/bin/perl -w                                       
use strict;

#open FILE, "<prova";

my $linea;
my $a = 0;


while ($linea = <>){
    if($linea !~ /^\*+\sContig/ && $linea !~ /^\s*$/){	
	if($linea =~ /DETAILED DISPLAY OF CONTIGS/){
	    exit;
	}
	$a++;
    }else{
	print $a."\n";
	$a = 0;

    }
#    print $a;
  
    
}

#close FILE;
