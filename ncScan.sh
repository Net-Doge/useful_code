#!/bin/bash
echo "Enter network address (e.g. 192.168.0): "
read net
echo "Enter starting host range (e.g. 1): "
read start
echo "Enter ending host range (e.g. 254): "
read end
echo "Enter ports space-delimited (e.g. 21-23 80): "
read ports
for ((i=$start; $i<=$end; i++))
do
    echo -n read_input | timeout 0.3 nc -nvzw1 $net.$i $ports 2>&1 | grep -E 'succ|open'
    #nc -nvzw1 $net.$i $ports 2>&1 | grep -E 'succ|open'
done
# (-v) running verbosely (-v on Linux, -vv on Windows),
# (-n) not resolving names. numeric only IP(no D.S)
# (-z) without sending any data. zero-I/O mode(used for scanning)
#(-w1) waiting no more than 1second for a connection to occur
# (2>&1) redirect STDERR to STDOUT. Results of scan are errors and need to redirect to output to grep
# (-E) Interpret PATTERN as an extended regular expression
# ( | grep open) for Debian to display only open connections
# ( | grep succeeded) for Ubuntu to display only the open connections
