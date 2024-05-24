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
