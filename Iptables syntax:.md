#IP/NFTables - Filtering T1
sudo iptables -A INPUT -p tcp -m multiport --ports 22,23,80,3389 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp -m multiport --ports 22,23,80,3389 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp -m multiport --ports 4444,6579 -j ACCEPT
sudo iptables -A OUTPUT -p tcp -m multiport --ports 4444,6579 -j ACCEPT
sudo iptables -A INPUT -p udp -m multiport --ports 4444,6579 -j ACCEPT
sudo iptables -A OUTPUT -p udp -m multiport --ports 4444,6579 -j ACCEPT
sudo iptables -A INPUT -p icmp -s 10.10.0.40 -j ACCEPT
sudo iptables -A OUTPUT -p icmp -d 10.10.0.40 -j ACCEPT
sudo iptables -P INPUT DROP
sudo iptables -P OUTPUT DROP
sudo iptables -P FORWARD DROP

#IP/NFTables - Filtering T3
sudo iptables -A INPUT -p tcp -m multiport --ports 22,23,80,3389 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp -m multiport --ports 22,23,80,3389 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -P INPUT DROP
sudo iptables -P OUTPUT DROP
sudo iptables -P FORWARD DROP


#############################################################################################################

#IP/NFTables - Filtering T2
#add the table CCTC
sudo nft add table ip CCTC
#create the base chains "mgmtIn" and "mgmtOut"
sudo nft add chain ip CCTC mgmtIn { type filter hook input priority 0 \; policy accept \;}
sudo nft add chain ip CCTC mgmtOut { type filter hook output priority 0 \; policy accept \;}
sudo nft add chain ip CCTC icmpIn { type filter hook input priority 0 \; policy accept \;}
sudo nft add chain ip CCTC icmpOut { type filter hook output priority 0 \; policy accept \;}
#create rules in the chain
sudo nft add rule ip CCTC mgmtIn tcp dport { 22, 23, 80, 3389, 5050-5150 } ct state { new, established } accept
sudo nft add rule ip CCTC mgmtIn tcp sport { 22, 23, 80, 3389, 5050-5150 } ct state { new, established } accept
sudo nft insert rule ip CCTC mgmtOut ct state { new, established } accept
sudo nft add rule ip CCTC mgmtOut tcp dport { 22, 23, 80, 3389, 5050-5150 } ct state { new, established } accept
sudo nft add rule ip CCTC mgmtOut tcp sport { 22, 23, 80, 3389, 5050-5150 } ct state { new, established } accept
sudo nft add rule ip CCTC mgmtIn udp dport { 5050-5150 } accept
sudo nft add rule ip CCTC mgmtIn udp sport { 5050-5150 } accept
sudo nft add rule ip CCTC mgmtOut udp dport { 5050-5150 } accept
sudo nft add rule ip CCTC mgmtOut udp sport { 5050-5150 } accept
sudo nft add rule ip CCTC icmpIn ip saddr 10.10.0.40 accept
sudo nft add rule ip CCTC icmpIn ip daddr 10.10.0.40 accept
sudo nft add rule ip CCTC icmpOut ip saddr 10.10.0.40 accept
sudo nft add rule ip CCTC icmpOut ip daddr 10.10.0.40 accept
sudo nft add rule ip CCTC icmpIn icmp type { * } accept
sudo nft add rule ip CCTC icmpOut icmp type { * } accept

#change chains to have DROP policy

sudo nft add chain ip CCTC mgmtIn { type filter hook input priority 0 \; policy drop \;}
sudo nft add chain ip CCTC mgmtOut { type filter hook output priority 0 \; policy drop \;}
sudo nft add chain ip CCTC icmpIn { type filter hook input priority 0 \; policy drop \;}
sudo nft add chain ip CCTC icmpOut { type filter hook output priority 0 \; policy drop \;}