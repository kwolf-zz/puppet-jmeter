# ex: syntax=puppet si ts=4 sw=4 et
class jmeter (
    $provider = $::jmeter::params::provider,
    $version  = $::jmeter::params::version,
    $plugins  = false,
    $plugins_version = $::jmeter::params::plugins_version,
) inherits jmeter::params {
    case $provider {
        tarball: {
            class { 'jmeter::install::tarball':
                version => $version,
            }
        }
        package: {
            class { 'jmeter::install::package':
                version => $version,
            }
        }
        default: {
            fail("Unknown provider for jmeter: ${provider}")
        }
    }

    if $plugins {
        class {'jmeter::install::plugins': }
    }
}
