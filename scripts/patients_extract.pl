#!/usr/bin/perl

sub check_args {
 my $x = scalar(@_);
 if ($x != 2) {
  print "Arguments: file folder\n " .
        "           file: input bundle of patients from Patient Manager\n" .
        "           folder: output folder with individual files\n";
  exit(1);
 }
 my ($input, $output) = @_;

 if (! -e $input) {
  print "Input file you specified does not exist: $input\n";
  exit 1;
 }
}

sub make_output_folder {
 my ($output) = @_;
 if (-e $output) {
  `rm -rf $output`;
   die "Unable to remove existing directory: $output\n" if ($? != 0);
 }

 `mkdir -p $output`;
  die "Unable to create output directory: $output\n" if ($? != 0);
}

sub read_file {
  my ($file) = @_;
  print "File: $file\n";
  open my $in, "<:encoding(utf8)", $file or die "$file: $!";
  my @lines = <$in>;
  close $in;
  return @lines;
}

sub find_id {
 foreach my $x (@_) {
  my $y = $x;
  if ($y =~ m/<id value=/) {
   chomp $y;
   $y =~ s/ *<id value="//;
   $y =~ s/".>//;
   return $y;
  }
 }
 return "NONE";
}

sub process_patient {
 my ($output_folder) = @_;
 shift @_;
 my $x = scalar(@_);
 my $id = find_id(@_);
 print "Process patient $x $id\n";
 my $file = $output_folder . "/" . $id . ".xml";

 open my $out, ">:encoding(utf8)", $file or die "$file: $!";
 foreach my $line(@_) {
  print $out $line;
 }
 close $out;
}

check_args(@ARGV);
my $input = $ARGV[0];
my $output_folder = $ARGV[1];
make_output_folder($output_folder);

@lines = read_file($input);

my $x = scalar(@lines);
print "$x\n";

my $count = 0;
my @patient_lines;
my $in_patient = 0;
foreach my $x (@lines) {
 if ($in_patient == 1) {
  push(@patient_lines, $x);
 }
 if ($x =~ m/<Patient/) {
  $in_patient = 1;
  push(@patient_lines, $x);
  $count++;
 }
 if ($x =~ m-</Patient>-) {
  $in_patient = 0;
  process_patient($output_folder, @patient_lines);
  @patient_lines = ();
 }
}

print "$count\n";
