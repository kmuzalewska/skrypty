#!/usr/bin/perl
#Klara Muzalewska

package rgx;

sub ifIntigers{
	if ($_[0] =~ /^[+-]?\d+$/){
		return 1;
	}else{
		return 0;
	}
}

sub ifDigit{
	if ($_[0] =~ /^[+-]?([\d]+\.[\d]*|\.?[\d]+)([eEqQdD][+-]?([\d]+\.[\d]*|\.?[\d]+))?$/){
		return 1;
	}else{
		return 0;
	}
}
1;	