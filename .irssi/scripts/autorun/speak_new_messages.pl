use strict;
use warnings;
use Irssi;
use Irssi::TextUI;

sub speak_message {
    my ($server, $text, $nick, $target) = @_;
    $text =~ s/\x03\d{0,2}(?:,\d{0,2})?//g;
    $text =~ s/[\x00-\x1F]//g;
    my $cmd = qq(espeak-ng -v en+f3 -s 140 -p 60 -a 150 "$nick says: $text");
    system("$cmd &");
}

Irssi::signal_add('message public', sub {
    my ($server, $msg, $nick, $address, $target) = @_;
    speak_message($server, $msg, $nick, $target);
});

Irssi::signal_add('message private', sub {
    my ($server, $msg, $nick, $address) = @_;
    speak_message($server, $msg, $nick, 'private');
});

Irssi::print("speak_new_messages.pl loaded - reading new messages with espeak-ng");

1;
