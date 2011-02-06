#!/usr/bin/python

import time;
from scipy.special import gammaln
from math import log, exp

def lnchoose(n, m):
  nf = gammaln(n + 1)
  mf = gammaln(m + 1)
  nmmnf = gammaln(n - m + 1)
  return nf - (mf + nmmnf)

def hypergeometric_gamma(k, n1, n2, t):
  if t > n1 + n2:
    t = n1 + n2
  if k > n1 or k > t:
    return 0
  elif t > n2 and ((k + n2) < t):
    return 0
  else:
    c1 = lnchoose(n1,k)
    c2 = lnchoose(n2, t - k)
    c3 = lnchoose(n1 + n2 ,t)

    return exp(c1 + c2 - c3)





def bincoeff1(n, r):
  if r < n - r:
    r = n - r
  x = 1
  for i in range(n, r, -1):
    x *= i
  for i in range(n - r, 1, -1):
    x /= i
  return x

def hypergeometric(k, n1, n2, t):
  if t > n1 + n2:
    t = n1 + n2
  if k > n1 or k > t:
    return 0
  elif t > n2 and ((k + n2) < t):
    return 0
  else:
    c1 = log(bincoeff1(n1,k))
    c2 = log(bincoeff1(n2, t - k))
    c3 = log(bincoeff1(n1 + n2 ,t))

    return exp(c1 + c2 - c3)



def enrichment_pvalue(m,mt,n,nt):
	pvalue=0.0;	
	ceiling=min(mt,n)+1;
	mtp=m-mt;
	for k in range(nt,ceiling):
		pvalue+=hypergeometric_gamma(k,mt,mtp,n);

	return pvalue;
	

def main():
  t = time.time()
  for i in range(10):
    r=enrichment_pvalue(19507150,11324,22457,17);
  print "time elapsed",time.time() - t


  print "r=",r;
  #print "r*=",r*135;
if __name__ == "__main__":
  main()



