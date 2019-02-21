#wfl.py
#
#problems compound tracker for word combos
#
#replaces the perl version
#

import os
import time
import re
import sys
import i7
from collections import defaultdict
from shutil import copy

words = defaultdict(lambda: defaultdict(bool))
prefix = defaultdict(lambda: defaultdict(lambda: defaultdict(bool)))
suffix = defaultdict(lambda: defaultdict(lambda: defaultdict(bool)))
to_check = defaultdict(bool)
in_flip = defaultdict(bool)
freqs = defaultdict(int)

overall_length = defaultdict(int)
results = defaultdict(str)

# string/list constants
flip = "flip.txt"
freq = "wfl-freq.txt"
freq2 = "wfl-freq2.txt"
tfd = "http://idioms.thefreedictionary.com/"

#local strings
freq_init = "#this is the frequency file for wfl.py.\n#it has word, # of times run, and whether or not we want to check the URL\n"
repl = { 'A': 'abcdefghijklmnopqrstuvwxyz', 'C': 'bcdfghjklmnpqrstvwxyz', 'V': 'aeiouy' }
ny = ['n', 'y']

#user modifiable variables
check_url = False
max_url_to_check = 10
maxlen = 15
max_mult_size = 1000
copy_and_delete = False

def usage(cmd = ""):
    if cmd: print("Bad command", cmd)
    print("====USAGE====")
    print("=" * 50)
    print("u# = launch idiom urls")
    print("m# = maximum number")
    print("-2 = needed for two-letter prefix/suffix")
    print("(LATER)")


#this could also be done with expand_caps but just in case there are huge numbers I figured I'd write this function out

def expand_size(j):
    idx = 1
    for q in repl:
        x = r'[{:s}]'.format(q)
        j = re.findall(x, sample_string)
        idx *= len(a[q]) ** len(j)
    return idx

def expand_caps(j):
    global arg
    for x in range(0, len(j)):
        if j[x].isupper():
            temp = []
            if j[x] not in repl: sys.exit("Unusable capital {:s} in {:s}.".format(j[x], arg))
            for q in repl[j[x]]: temp = temp + (expand_caps(j.replace(j[x], q, 1)))
            return temp
    return [j]

def unsaved_flip_file():
    with open(i7.np_xml) as file:
        for line in file:
            if 'flip.txt' in line and 'backupFilePath=' in line:
                print(i7.np_xml, "is logged as unsaved. Please save and re-run.")
                return True
    return False

def occur(x):
    y = x.split("\n")
    if "=" in y[0]:
        my_word = re.sub(^=*", "", y[0])
        my_word = re.sub(" .*", "", my_word)
        my_num = re.sub(".*\(", "", y[0])
        my_num = re.sub("\).*", "", my_num)
        return (my_num, my_word)
    if y[-1].startswith("=="):
        if 'matches' in y: # ====Found x matches x maybes x total
            my_num = re.sub(" total.*", "", y[-1])
            my_num = int(re.sub(".* ", "", my_num))
            my_word = re.sub(".* for ", "", y[-1])
            return (my_num, my_word)
        else: #OLD FORMAT: ====Found 147/102 for cow
            my_num = re.sub("\/.*", "", y[-1])
            my_num = int(re.sub(".* ", "", my_num))
            my_word = re.sub(".* for ", "", y[-1])
            return (my_num, my_word)
    sys.exit("BAILING could not create number/word tuple for:\n    {:s}\n".format(y[0]))

def order_flip_file(data_array, copy_and_delete = False):
    if unsaved_flip_file():
        print(flip, "is unsaved in notepad.txt. Open it and save before re-running.")
        exit(0)
    data_array = sorted(data_array, key=lambda x:(occur_tuple(x))
    f = open(flip2, "w")
    f.write("\n".join(data_array))
    f.close()
    if copy_and_delete:
        copy(flip2, flip)
        os.delete(flip2)
    else:
        print("-cd sets copy/delete which is currently off.")
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
    return_string = "========{:s} ({:d})\n".format(partwd, total) + "\n".join(match_str) + "\n".join(maybe_str) + "\n===============Found {:d} matches {:d} maybes {:d} total for {:s}".format(matchs,maybes,total,partwd)
    if matchs + maybes: freqs[partwd] += 1
    sys.exit(return_string)
    return(return_string,matchs,maybes,total)

prefix_preload = False
count = 1
two_okay = False
words_to_process = []

while count < len(sys.argv):
    arg = sys.argv[count]
    anh = arg
    if anh[0] == '-': anh = anh[1:]
    if anh == 'f' or anh == 'fl': os.system(flip)
    elif anh == 'fr': os.system(freq)
    elif anh == '2': two_okay = True
    elif anh[0] == 'm' and arg[1:].isdigit(): max_mult_size = int(arg[1:])
    elif re.search("[VCA]", arg):
        if len(arg) < 3:
            usage("Wild card with 2 letter word potentially gives too many combos.")
            exit()
        qs = expand_size(arg)
        if qs > max_mult_size: sys.exit("Quicksizing {:s} gives {:d} possibilities, which over the maximum if {:d}. Change it with -m#.".format(arg, qs, max_mult_size))
        words_to_process = words_to_process + temp
    elif anh[0] == 'u' and isdigit(anh[1:]):
        check_url = True
        max_url_to_check = int(anh[1:])
        if max_url_to_check < 0:
            sys.exit("-u requires a positive integer right after, no spaces")
        get_freq_tried()
        launch_my_urls()
        exit()
    elif anh == '?':
        usage()
        exit()
    elif arg[0] == '-':
        usage("bad dash command")
        exit()
    else:
        if len(anh) == 1:
            usage("Unknown 1-word command {:s}".format(arg))
            exit()
        if len(anh) == 2 and not two_okay:
            usage("Need -2 flag at start to process 2-length word {:s}".format(arg))
            exit()
        words_to_process.append(arg)
    count += 1

get_in_flip()

b4 = time.time()

with open(i7.f_dic) as file:
    for line in file:
        l = line.lower().strip()
        words[len(l)][l] = True
        if prefix_preload:
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
    if temp[1] + temp[2]: data_to_add.append(temp[0])

if len(data_to_add):
    order_flip_file(data_to_add)
else:
    print("Nothing to add to flip file.")

write_freq_file()

# get_freq_tried()



