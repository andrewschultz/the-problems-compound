#wfl.py
#
#problems compound tracker for word combos
#
#replaces the perl version
#

import time
import re
import sys
import i7
from collections import defaultdict

words = defaultdict(lambda: defaultdict(bool))
prefix = defaultdict(lambda: defaultdict(lambda: defaultdict(bool)))
suffix = defaultdict(lambda: defaultdict(lambda: defaultdict(bool)))
to_check = defaultdict(bool)
in_flip = defaultdict(bool)
freqs = defaultdict(int)

overall_length = defaultdict(int)
results = defaultdict(str)

# file / url constants
flip = "flip.txt"
freq = "wfl-freq.txt"
freq2 = "wfl-freq2.txt"
tfd = "http://idioms.thefreedictionary.com/"

freq_init = "#this is the frequency file for wfl.py.\n#it has word, # of times run, and whether or not we want to check the URL\n"

ny = ['n', 'y']
check_url = False
max_url_to_check = 10

maxlen = 15

def usage(cmd = ""):
    if cmd: print("Bad command", cmd)
    print("====USAGE====")
    print("=" * 50)
    print("(LATER)")

def unsaved_flip_file():
    with open(i7.np_xml) as file:
        for line in file:
            if 'flip.txt' in line and 'backupFilePath=' in line:
                print(i7.np_xml, "is logged as unsaved. Please save and re-run.")
                return True
    return False

def order_flip_file():
    if unsaved_flip_file():
        print(flip, "is unsaved in notepad.txt. Open it and save before re-running.")
        exit(0)
    return

def write_freq_file():
    f = open(freq2, "w")
    f.write(freq_init)
    for x in sorted(to_check): f.write("{:s},{:s},{:s}\n".format(x, freqs[x], ny[to_check[x]]))
    f.close()

def get_freq_tried():
    with open(freq) as text:
        for (line_count, line) in enumerate(text, 1):
            if line.startswith("#"): continue
            if line.startswith(";"): continue
            l = line.lower().strip().split(",")
            freqs[l[0]]=l[1]
            if l[2] == 'y': to_check[l[2]] = True

def launch_my_urls():
    if check_url:
        q = sorted(to_check)
        if not len(q): sys.exit("No more URLs to check.")
        print(len(q), "URLs to check:", '/'.join(q))
        if len(to_check) > max_url_to_check:
            print("Skipping", len(q) - max_url_to_check, "entries")
        for x in range(0, max_url_to_check):
            os.system(tfd + x)
            to_check[x] = False
            write_freq_file()
        exit()

def get_in_flip():
    the_buffer = ""
    with open(flip) as file:
        for (line_count, line) in enumerate(file, 1):
            if line.startswith("=") and 'for' in line:
                l = line.lower().strip()
                l2 = re.sub(".* for ", "", l)
                in_flip[l2] = True
                l3 = re.sub(" (total for|found).*", "", l)
                overall_length[l2] = l3
                results[l2] = l3
                the_buffer = ""
            else:
                the_buffer += line
    if the_buffer:
        print("There is a leftover buffer in {:s}.".format(flip))
        print("It is:",the_buffer.strip())

def data_from_one(partwd):
    match_str = []
    maybe_str = []
    matchs = 0
    maybes = 0
    lp = len(partwd)
    for q in range(len(partwd)+1, maxlen+1):
        for j in words[q]:
            if j.startswith(partwd):
                if j[lp:] in words[q-lp]:
                    match_str.append("{:s}+{:s}={:s}*".format(partwd, j[lp:], j))
                    matchs += 1
                else:
                    maybe_str.append("{:s}+{:s}={:s}".format(partwd, j[lp:], j))
                    maybes += 1
            if j.endswith(partwd):
                if j[:-lp] in words[q-lp]:
                    match_str.append("{:s}+{:s}={:s}*".format(j[:-lp], partwd, j))
                    matchs += 1
                else:
                    maybe_str.append("{:s}+{:s}={:s}".format(j[:-lp], partwd, j))
                    maybes += 1
    total = matchs + maybes
    match_str = sorted(match_str)
    maybe_str = sorted(maybe_str)
    return_string = "\n".join(match_str) + "\n".join(maybe_str) + "=============== {:d} matches {:d} maybes {:d} total for {:s}".format(matchs,maybes,total,partwd)
    if matchs + maybes: freqs[partwd] += 1
    return(matchs,maybes,total)

count = 1
two_okay = False
words_to_process = []

while count < len(sys.argv):
    arg = sys.argv[count]
    if arg == 'f' or arg == 'fl': os.system(flip)
    elif arg == 'fr': os.system(freq)
    elif arg == '2': two_okay = True
    elif arg[0] == 'u':
        check_url = True
        if len(arg) > 1:
            try:
                max_url_to_check = int(arg[1:])
            except:
                sys.exit("-u requires an integer right after, no spaces")
        get_freq_tried()
        launch_my_urls()
        exit()
    elif arg == '?':
        usage()
        exit()
    else:
        if len(arg) == 1:
            print("Unknown 1-word command", arg)
            usage()
            exit()
        if len(arg) == 2 and not two_okay:
            print("Need -2 flag at start to process 2-length word", arg)
            usage()
            exit()
        words_to_process.append(arg)
    count += 1

get_in_flip()

b4 = time.time()

with open(i7.f_dic) as file:
    for line in file:
        l = line.lower().strip()
        words[len(l)][l] = True
        continue
        for x in range (2, len(l)): # this is a bit slow
            prefix[x][l[:x]][l] = True
            suffix[x][l[-x:]][l] = True

af = time.time()
print(b4, af, af - b4)

data_to_add = []
w2 = []

for q in words_to_process:
    if q in in_flip: print(q, "is duplicate")
    else:
        w2.append(q)

words_to_process = list(w2)

for q in words_to_process:
    temp = data_from_one(q)
    if temp[1] + temp[2]: data_to_add.append(data_from_one)

if len(data_to_add):
    order_flip_file(data_to_add)
else:
    print("Nothing to add to flip file.")

write_freq_file()

# get_freq_tried()



