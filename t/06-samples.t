use strict;
use warnings;

use Test::More;
BEGIN {
    eval "require Test::XML";
    plan skip_all => "Test::XML required for this test" if $@;
    plan tests => 16;
    Test::XML->import;

    use_ok 'XML::WBXML';
    use_ok 'XML::SemanticDiff::BasicHandler';
    {
	no warnings 'redefine';
	*XML::SemanticDiff::BasicHandler::namespace_uri = sub {};
    }
} 


for my $i (qw/001 002 003 004 005 006 007 008 009 010 011 012 013 014/) {
    open my $fh, '<', "t/syncml-samples/syncml-$i.xml" or die "can't open sample $i: $!";
    my $xml = do { local $/; <$fh> };
    my $wbxml = XML::WBXML::xml_to_wbxml($xml);
    my $xml_roundtrip = XML::WBXML::wbxml_to_xml($wbxml);

    is_xml($xml_roundtrip, $xml, "sample $i roundtrips successfully");
} 
