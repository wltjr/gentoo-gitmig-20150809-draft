#!/usr/bin/env python

import sys
import os
norm=os.path.normpath
import string
from commands import *

def pkgscript(x):
	myresult=getstatusoutput("/usr/bin/ebuild "+myebuildfile+" "+x)
	if myresult[0] or myresult[1]:
		print
	if myresult[0]:
		print "Error code from",pkgname,x,"script --",myresult[0]
	if myresult[1]:
		print "Output from",pkgname,x,"script:"
		print
		print myresult[1]

def md5(x):
	myresult=getstatusoutput("/usr/bin/md5sum "+x)
	return string.split(myresult[1]," ")[0]

def getmtime(x):
	 return `os.lstat(x)[-2]`

try:
	myroot=os.environ["ROOT"]
except KeyError:
	myroot="/"

for pkgname in sys.argv[1:]:
	if os.path.isdir(os.path.normpath(myroot+"var/db/pkg/"+pkgname)):
		if myroot=="/":
			print "Unmerging",pkgname+"..."
		else:
			print "Unmerging",pkgname,"from",myroot+"..."
		print
	else:
		print pkgname,"not installed"
		continue
	try:
		contents=open(os.path.normpath(myroot+"var/db/pkg/"+pkgname+"/CONTENTS"))
	except:
		print "Error -- could not open CONTENTS file for", pkgname+".  Aborting."
		sys.exit(1)
	pkgfiles={}
	for line in contents.readlines():
		mydat=string.split(line)
		# we do this so we can remove from non-root filesystems
		# (use the ROOT var to allow maintenance on other partitions)
		mydat[1]=os.path.normpath(myroot+mydat[1][1:])
		if mydat[0]=="obj":
			#format: type, mtime, md5sum
			pkgfiles[mydat[1]]=[mydat[0], mydat[3], mydat[2]]
		elif mydat[0]=="dir":
			#format: type
			pkgfiles[mydat[1]]=[mydat[0] ]
		elif mydat[0]=="sym":
			#format: type, mtime, dest
			pkgfiles[mydat[1]]=[mydat[0], mydat[4], mydat[3]]
		else:
			print "Error -- CONTENTS file for", pkgname, "is corrupt."
			print ">>> "+line
			sys.exit(1)
	# we don't want to automatically remove the ebuild file listed
	# in the CONTENTS file.  We'll do after everything else has 
	# completed successfully.
	myebuildfile=os.path.normpath(myroot+"var/db/pkg/"+pkgname+"/"+pkgname+".ebuild")
	if pkgfiles.has_key(myebuildfile):
		del pkgfiles[myebuildfile]

	mykeys=pkgfiles.keys()
	mykeys.sort()
	mykeys.reverse()
	
	#prerm script
	pkgscript("prerm")
	
	for obj in mykeys:
		obj=norm(obj)
		if not os.path.exists(obj):
			print "--- !found", pkgfiles[obj][0], obj
			continue
		if (pkgfiles[obj][0]!="dir") and (getmtime(obj) != pkgfiles[obj][1]):
			print "--- !mtime", pkgfiles[obj][0], obj
			continue
		if pkgfiles[obj][0]=="dir":
			if not os.path.isdir(obj):
				print "--- !dir  ","dir", obj
				continue
			if os.listdir(obj):
				print "--- !empty","dir", obj
				continue
			os.rmdir(obj)
			print "<<<       ","dir",obj
		elif pkgfiles[obj][0]=="sym":
			if not os.path.islink(obj):
				print "--- !sym  ","sym", obj
				continue
			mydest=os.readlink(obj)
			if mydest != pkgfiles[obj][2]:
				print "--- !destn","sym", obj
				continue
			os.unlink(obj)
			print "<<<       ","sym",obj
		elif pkgfiles[obj][0]=="obj":
			if not os.path.isfile(obj):
				print "--- !obj  ","obj", obj
				continue
			mymd5=md5(obj)
			if mymd5 != pkgfiles[obj][2]:
				print "--- !md5  ","obj", obj
				continue
			os.unlink(obj)
			print "<<<       ","obj",obj
	#postrm script
	pkgscript("postrm")	
	#recursive cleanup
	for thing in os.listdir(myroot+"var/db/pkg/"+pkgname):
		os.unlink(myroot+"var/db/pkg/"+pkgname+"/"+thing)
	os.rmdir(myroot+"var/db/pkg/"+pkgname)
	print
	if myroot=="/":
		print pkgname,"unmerged."
	else:
		print pkgname,"unmerged from",myroot+"."
