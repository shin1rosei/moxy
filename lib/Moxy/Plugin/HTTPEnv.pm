package Moxy::Plugin::HTTPEnv;
use strict;
use warnings;
use base qw/Moxy::Plugin/;
use HTTP::MobileAgent;

sub register {
    my ($class, $context) = @_;

    $context->register_hook(
        request_filter_E => sub {
            my ($context, $args) = @_;

            # EZの画面情報
            if ($args->{agent} && $args->{agent}->{width}) {
                $args->{request}->header(
                    'X-UP-DEVCAP-SCREENPIXELS' => $args->{agent}->{width} . "," . 
                                                        $args->{agent}->{height} );
            }
            # Flash使えるかどうか
            if ($args->{agent} && $args->{agent}->{flash}) {
                $args->{request}->header(Accept => "application/x-shockwave-flash");
            }
        }
    );

    $context->register_hook(
        request_filter_V => sub {
            my ($context, $args) = @_;

            # SoftBankの画面情報
            if ($args->{agent} && $args->{agent}->{width}) {
                $args->{request}->header(
                    'X-JPHONE-DISPLAY' => $args->{agent}->{width} . "*" . 
                                          $args->{agent}->{height} );
            }
        }
    );
}

1;
__END__

=head1 NAME

Moxy::Plugin::HTTPEnv - set the http headers

=head1 SYNOPSIS

  - module: HTTPEnv

=head1 DESCRIPTION

set some http headers.

=head1 KNOWN BUGS

    hey. this is bad name.

=head1 SEE ALSO

L<Moxy>