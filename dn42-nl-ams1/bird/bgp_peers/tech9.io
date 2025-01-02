/*

ssh cli@cli.dn42.tech9.io

>> login 4242420263
Password:
Successfully logged in. Type 'help' for commands.
>> show peerings
+------+------------------------------+------------------------------+----------------------------------------------+---------------------+---------------------+---------------------+----------------------------------------------+------+
| ID   | Peering Endpoint             | Address                      | Public Key                                   | Your Endpoint       | BGP Endpoint (IPv4) | BGP Endpoint (IPv6) | Your Public Key                              | MBGP |
+------+------------------------------+------------------------------+----------------------------------------------+---------------------+---------------------+---------------------+----------------------------------------------+------+
| 2340 | de-fra02.dn42.tech9.io:53700 | 172.20.16.141, fe80::1588/64 | MD1EdVe9a0yycUdXCH3A61s3HhlDn17m5d07e4H33S0= | 51.15.171.197:51820 | 172.22.144.163      | fe80::100           | 8JNlIxV5BTOxNBB2wDs/A5HSvzcZxSLbIEVzz7b94Qc= | true |
+------+------------------------------+------------------------------+----------------------------------------------+---------------------+---------------------+---------------------+----------------------------------------------+------+

*/

define TECH9_LATENCY = 3; # latency in [7.3ms, 20ms]

protocol bgp tech9_v6 from dnpeers {
    neighbor fe80::1588 as 4242421588;
    interface "wg-peer-tech9";

    ipv4 {
        import where dn42_import_filter(TECH9_LATENCY, BANDWIDTH, LINKTYPE);
        export where dn42_export_filter(TECH9_LATENCY, BANDWIDTH, LINKTYPE);
    };

    ipv6 {
        import where dn42_import_filter_v6(TECH9_LATENCY, BANDWIDTH, LINKTYPE);
        export where dn42_export_filter_v6(TECH9_LATENCY, BANDWIDTH, LINKTYPE);
    };
}
