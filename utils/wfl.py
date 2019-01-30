import sys
import i7
from collections import defaultdict

words = defaultdict(lambda: defaultdict(bool))
to_check = defaultdict(bool)
in_flip = defaultdict(bool)

overall_length = defaultdict(int)
results = defaultdict(str)

flip = "flip.txt"
freq = "wfl-freq.txt"
freq_init = "#this is the frequency file for wfl.py.\n#it has word, # of times run, and whether or not we want to check the URL"

def get_freq_tried()
	with open(freq) as text:
		for (line_count, line) in enumerate(freq, 1):
			if line.startswith("#"): continue
			if line.startswith(";"): continue
			l = line.lower().strip().split(",")
			freqs[l[0]]=l[1]
			if l[2] == 'y': to_check[l[2]] = True
	print(len(to_check), "URLs to check:", '/'.join(to_check))

def get_in_flip():
	the_buffer = ""
	with open(flip) as file:
		for (line_count, line) in enumerate(freq, 1):
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
		sys.exit("There is a leftover buffer in", flip)
		print(the_buffer.strip())

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
					match_str.append("{:s}+{:s}={:s}*".format(j[lp:], partwd, j))
					matchs += 1
				else:
					maybe_str.append("{:s}+{:s}={:s}".format(j[lp:], partwd, j))
					maybes += 1
			if j.endswith(partwd):
				if j[:-lp] in words[q-lp]:
					match_str.append("{:s}+{:s}={:s}*".format(partwd, j[lp:], j))
					matchs += 1
				else:
					maybe_str.append("{:s}+{:s}={:s}".format(partwd, j[lp:], j))
					maybes += 1
	total = matchs + maybes
	match_str = sorted(match_str)
	maybe_str = sorted(maybe_str)
	print("\n".join(match_str))
	print("\n".join(maybe_str))
	print("===============",matchs,"matches",maybes,"maybes",total,"total for",partwd)

with open(i7.f_dic) as file:
	for line in file:
		l = line.lower().strip()
		words[len(l)][l] = True

get_freq_tried()

get_in_flip()

maxlen = max(words, key=int)

