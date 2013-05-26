#!/usr/bin/perl -w
use strict;
use Getopt::Std;
use File::Basename;
use File::Find::Rule;
my ($file, $dir, $newfile, @music_files);
our ($opt_c);
getopts('c');

my $commit = 0;
if ($opt_c) { $commit = 1 };

if (@ARGV) { $dir = $ARGV[0];
    } else {
    print "Invalid or missing subdirectory \n";
    usage();
    exit;
}
unless ($dir) { usage() };
#@music_files = File::Find::Rule->name('*.ogg')->in('/home/tim/music');
my $rule = File::Find::Rule->new;
$rule->file;
$rule->name('*.mp3', '*.ogg');
@music_files = $rule->in( $dir );

foreach $file (@music_files) {
	my ($nfile, $prefix,) = fileparse($file); 
	my $newfile = $nfile;
	$newfile =~ s/\.//;
	my $f1 = $prefix . $nfile;
	my $f2 = $prefix . $newfile;
	print "Before:$f1\n";
	print " After:$f2\n";
	if ($commit == 1) {
		system "mv \"$f1\" \"$f2\"";
	}
}

sub usage {
	print "Usage: rmdot.pl [-c} <path>\n";
	print "       -c to really make the change, otherwise\n";
	print "       just testing. \n";
	
}

