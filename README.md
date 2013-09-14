Word At Index 0.0.2
===================

  Returns the word of a mask given its index.
	Purpose: split a mask for eg distributed computing [brute force]

	pc1 -> mask[0-100000000]
	pc2 -> mask[100000001-200000000]
	...

	Usage: bash wai.sh -i index -m mask [customCharSet]
	eg.  
		bash wai.sh -i1000000 -m?d?d?d?d?d?d?d?d
	will output
		'00999999'
	surrounding '' are needed to make sure the space char wont be forgotten

	* Info:
	  -p,  to display the full output additional to the word at index -i
	  -v,  Display version number
	  -h,  Display this help menu

	* generation:

	  -i,  Index for Word; fist word at index 1
	  -m,  Specify mask via Built-in charsets

	       Example:
	       
	       bash wai.sh -i 13 -m ?d?d
	       
	* Custom charsets:

	  -1, -2, -3, -4,  Specify custom charsets via Built-in charsets

	       Example:

	       bash wai.sh -i 13 -m ?1?d?1 -1 ?dabcDE  
	       
	       IMPORTANT -1 ?d?l NOT EQUAL -1 ?l?d

	* Built-in charsets:

	  ?l = 'abcdefghijklmnopqrstuvwxyz'
	  ?u = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	  ?d = '0123456789'
	  ?s = ' !\"#\$%&'()*+,-./:;<=>?@[\\]^_\`{|}~'
		without surrounding ''

ENJOY & BE NICE ;)

changelog 0.0.2 - added -p option
  WAI will now only return the word at index -i inside single quotes '' 
	instead of the bulky output information which can be added via -p
	this will hopefully enable easy pipelining	