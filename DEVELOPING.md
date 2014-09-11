# Gotta Be Afraid 

Basic concepts of scraping and mechanizing a website through the Tor network.


## Login Process
* https://freedns.afraid.org/zc.php
* https://freedns.afraid.org/domain/registry/page-?.html
* https://freedns.afraid.org/logout/

```html
<input type="text" name="username" size="16" maxlength="16">
<input type="password" name="password" size="16" maxlength="16">

<input id="oPersistInput" class="storeuserData" type="hidden" name="remote">
<input type="hidden" value="" name="from">
<input type="hidden" value="auth" name="action">

<input type="submit" onclick="fnAlertInput()" value="Login" name="submit">
```



## Cookie Information

* dns_cookie appears to be the primary cookie
* PHPSESSID was servered at somepoint as the cookie._


## Scrape Target


* GET https://freedns.afraid.org/domain/registry/page-?.html

```html
<tr class="trl">
<td>
<a href="/subdomain/edit.php?edit_domain_id=29">mooo.com</a>
<br>
<span>
(176366 hosts in use)
<a href="http://www.mooo.com/" rel="nofollow" target="_blank">website</a>
</span>
</td>
<td>public</td>
<td>
<a href="/tools/contact.php?user_id=1&subject=mooo.com">josh</a>
</td>
<td>4275 days ago (03/15/2001)</td>



<html lang="EN">
<head>
<body vlink="#808080" text="#000000" link="#000000" bgcolor="cornflowerblue" alink="#000000">
<table width="100%" height="100%" cellspacing="5" border="0">
<tbody>
<tr>
<tr>
<td width="15%" valign="top" bgcolor="white" align="center">
<td bgcolor="white">
<br>
<center>
<center>
<table width="90%" border="0">
<form action="/domain/registry/"></form>
<input type="hidden" value="5" name="sort">
<tbody>
<tr>
<tr>
<tr>
<td bgcolor="#cccccc" colspan="4">
</tr>
<tr class="trl">
</pre>
```

### XPaths
Simple XPath for Domain Name only

	["//tr[@class='trd']/td/span/a", "//tr[@class='trl']/td/span/a"]

	-  href class of a node is the domainname.

Complex XPATH for Deep Data

	["//tr[@class='trd']", "//tr[@class='trl']"]

Then dig into 
		
	
	td[0]/a/innerhtml = Domain Name
		b.children[0].xpath('.//a')[0].children[0].to_s
	
	td[0]/span/text = Number of Subdomains "(544 hosts in use)"
		b.children[0].xpath('.//span')[0].children[0].to_s
	
	td[1] = Public / Private
		b.children[1].children[0].to_s
		
	td[2]/a/innerhtml = Username
		b.children[2].xpath('.//a')[0].children[0].to_s
	
	td[3] = Age "1169 days ago (09/07/2009)"
		b.children[3].children[0].to_s


### XPATH Match Example

	#(Element:0x3fcf5cc75298 {
	  name = "tr",
	  attributes = [ #(Attr:0x3fcf5cc75220 { name = "class", value = "trl" })],
	  children = [
	    #(Element:0x3fcf5cc78074 {
	      name = "td",
	      children = [
	        #(Element:0x3fcf5cc77890 {
	          name = "a",
	          attributes = [
	            #(Attr:0x3fcf5cc77688 {
	              name = "href",
	              value = "https://example.com/subdomain/edit.php?edit_domain_id=153370"
	              })],
	          children = [ #(Text "bestforever.com")]
	          }),
	        #(Element:0x3fcf5cc7ba58 { name = "br" }),
	        #(Element:0x3fcf5cc7af18 {
	          name = "span",
	          children = [
	            #(Text " (280 hosts in use) "),
	            #(Element:0x3fcf5cc7d7a4 {
	              name = "a",
	              attributes = [
	                #(Attr:0x3fcf5cc7d5b0 { name = "target", value = "_blank" }),
	                #(Attr:0x3fcf5cc7d59c { name = "rel", value = "nofollow" }),
	                #(Attr:0x3fcf5cc7d4fc {
	                  name = "href",
	                  value = "http://www.bestforever.com/"
	                  })],
	              children = [ #(Text "website")]
	              })]
	          })]
	      }),
	    #(Element:0x3fcf5cc847fc { name = "td", children = [ #(Text "public")] }),
	    #(Element:0x3fcf5cc85da0 {
	      name = "td",
	      children = [
	        #(Element:0x3fcf5cc856d4 {
	          name = "a",
	          attributes = [
	            #(Attr:0x3fcf5cc855e4 {
	              name = "href",
	              value = "https://example.com/tools/contact.php?user_id=263456&subject=bestforever.com"
	              })],
	          children = [ #(Text "shang")]
	          })]
	      }),
	    #(Element:0x3fcf5cc87844 {
	      name = "td",
	      children = [ #(Text "2178 days ago (12/11/2006)")]
	      })]
	  })

## Brandable DNS servers

afraid.org account, setup/create ns1-ns4.YOURBUSINESS.COM to point to afraid.org's IPs like so:

	NS1.YOURBUSINESS.COM (50.23.197.95)
	NS2.YOURBUSINESS.COM (174.37.196.55)
	NS3.YOURBUSINESS.COM (72.20.15.62)
	NS4.YOURBUSINESS.COM (174.128.246.102)
