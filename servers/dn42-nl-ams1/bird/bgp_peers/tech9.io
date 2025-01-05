/*

ssh cli@cli.dn42.tech9.io

>> login 4242420263
Password:
Successfully logged in. Type 'help' for commands.
>> show peerings
+------+------------------------------+-------------------------------+----------------------------------------------+----------------------+---------------------+---------------------+----------------------------------------------+------+
| ID   | Peering Endpoint             | Address                       | Public Key                                   | Your Endpoint        | BGP Endpoint (IPv4) | BGP Endpoint (IPv6) | Your Public Key                              | MBGP |
+------+------------------------------+-------------------------------+----------------------------------------------+----------------------+---------------------+---------------------+----------------------------------------------+------+
| 2832 | nl-ams01.dn42.tech9.io:54422 | 172.23.220.192, fe80::1588/64 | opEMCeB+Zepf/lMabVndWVOmKVHI3Bvc98hm55TAxGI= | 51.158.153.183:51820 | 172.22.144.161      | fe80::100           | osOFClUbgPmF9XVWhUtvatWjM0y0ZgTi0xnitirnphA= | true |
+------+------------------------------+-------------------------------+----------------------------------------------+----------------------+---------------------+---------------------+----------------------------------------------+------+

*/

define TECH9_LATENCY = 1; # latency in [0ms, 2.7ms]

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
