use 5.008008;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'quoi',
#    VERSION_FROM      => 'lib/CljPerl.pm', # finds $VERSION
    PREREQ_PM         => {"AnyEvent" => 7.04,
                          "AnyEvent::HTTP" => 2.15,
			  "Protocol::WebSocket" => 0.12,
		          "AnyEvent::HTTPD" => 0.93,
		          "AnyEvent::DBI" => 2.3,
		          "URI" => 1.60,}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (AUTHOR         => 'Wei Hu <huwei04@hotmail.com>') : ()),
);
