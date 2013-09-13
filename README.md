Word At Index 0.0.1
===================

	wordAtIndex generator by Hannes Rammer,
	Returns the word of a mask given its index.
	Purpose: split a mask for eg distributed computing [brute force]

	pc1 -> mask[0-100000000]
	pc2 -> mask[100000001-200000000]
	...

	Usage: bash wai.sh -i index -m mask [(-1 -2 -3 -4) customMask] [charset]

	* Info:

	  -v,  Display version number
	  -h,  Display this help menu

	* Generation:

	  -i,  Index for Word; fist word at index 1
	  -m,  Specify mask via Built-in charsets

	       Example:
	       
	       bash wai.sh -i 13 -m ?d?d?d  
	     
	* Custom charsets:

	  -1, -2, -3, -4,  Specify custom charsets via Built-in charsets or single characters

	       Example:

	       bash wai.sh -i13 -m?1?d?2a -1?dab -2?u9

	       sets charset ?1 to 0123456789ab and ?2 to ABCDEFGHIJKLMNOPQRSTUVWXYZ9
	 
	       IMPORTANT -1 ?d?l NOT EQUAL -1 ?l?d

	* Built-in charsets:

	  ?l = abcdefghijklmnopqrstuvwxyz
	  ?u = ABCDEFGHIJKLMNOPQRSTUVWXYZ
	  ?d = 0123456789
	  ?s =  !\"#\$%&'()*+,-./:;<=>?@[\\]^_\`{|}~

ENJOY & BE NICE ;)