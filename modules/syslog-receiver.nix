{ pkgs, ... }:

{
  systemd.services.syslog-recv = {
    description = "Syslog UDP Receiver";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      StandardOutput = "syslog";
      ExecStart = pkgs.writeScript "syslog-recv" ''
        #!${pkgs.python3}/bin/python3

        import re;
        import socket;
        import sys;

        sock = socket.socket(type=socket.SocketKind.SOCK_DGRAM, family=socket.AF_INET6);
        sock.bind(("::", 514));

        while True:
          try:
            msg = sock.recv(1024 * 1024).decode('utf-8')
            m = re.search('<(\d+)>(.*)', msg)
            prio = int(m.group(1)) & 7
            print(f"<{prio}>{m.group(2)}", file=sys.stderr)
          except Exception as e:
            print(f"<4>could not handle message: {str(e)}", file=sys.stderr)
      '';
    };
  };
}
