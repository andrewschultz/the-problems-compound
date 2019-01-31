#
# fl2.py: this is a script that determines a name that is both a first and last name.
#
# no arguments needed.
#
# used for Buddy Best's random case studies.
#

from collections import defaultdict

firsts = defaultdict(bool)
lasts = defaultdict(bool)

def look_for_1_dif(string1, string2):
    if abs(len(string1) - len(string2)) > 1: return False
    if len(string1) < len(string2):
        string1, string2 = string2, string1
    it1 = iter(string1)
    it2 = iter(string2)
    count_diffs = 0
    c1 = next(it1, None)
    c2 = next(it2, None)
    while True:
        # print(string1, string2, c1,c2)
        if c1 != c2:
            if count_diffs: return False
            count_diffs = 1
            try:
                c1 = next(it1)
                if len(string1) == len(string2):
                    c2 = next(it2)
            except StopIteration:
                return True
        else:
            try:
                c1 = next(it1)
                c2 = next(it2)
            except StopIteration:
                return True
    return True

with open("c:/writing/dict/firsts.txt") as file:
	for line in file:
		firsts[line.strip().lower()] = True

with open("c:/writing/dict/lasts.txt") as file:
	for line in file:
		lasts[line.strip().lower()] = True

# print(firsts.keys())

my_set = sorted(set(firsts.keys()) & set(lasts.keys()))

a_index = 0

last_string = ''

fout = open("flboth.txt", "w")
for a in my_set:
    fout.write("\"{:s}\"\n".format(a[0].upper() + a[1:]))
fout.close()

fout = open("fl2.txt", "w")
for a in my_set:
    count = 0
    for b in my_set:
        if a != b and look_for_1_dif(a, b):
            if a != last_string:
                a_index = a_index + 1
            count = count + 1
            fout.write("{:d} {:d} {:s} {:s}\n".format(a_index, count, a, b))
            last_string = a
fout.close()

print(','.join(my_set))
