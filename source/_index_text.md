This is a tutorial for working through applying HTML5 Microdata using the
schema.org vocabulary to a library's digital special collections pages. 

NOTE: YKK in the text here is just an indication that something needs filled in still.

HTML5 Microdata is... YKK
  
Schema.org is... YKK  

Here's an example:

<p itemscope="" itemtype="Person" class="md">
  This tutorial was created by 
  <a href="http://twitter.com/#!/ronallo" itemprop="url"><span itemprop="name">Jason Ronallo</span></a>, 
  <span itemprop="jobTitle">Digital Collections Technology Librarian</span> at
  <span itemprop="affiliation" itemscope="" itemtype="Organization"><a href="http://www.lib.ncsu.edu/" itemprop="url"><span itemprop="name">North Carolina State University Libraries</span></a></span>. 
  Feel free to contact me about this tutorial or microdata and schema.org
  generally, at <span itemprop="email">jronallo@gmail.com</span>.
</p>

In this tutorial item properties are highlighted with a light yellow background
to help find the new microdata that has been added to the page.


While you can inspect the above markup with Chrome's Developer Tools or 
Firefox's Firebug, here's the markup for the snippet. (YKK make sure the code is updated.)



    <p itemscope itemtype="Person" class="md">
      This tutorial was created by 
      <a href="http://twitter.com/#!/ronallo" itemprop="url"><span itemprop="name">Jason Ronallo</span></a>, 
      <span itemprop="jobTitle">Digital Collections Technology Librarian</span> at
      
      <span itemprop="affiliation" itemscope itemtype="Organization"><a href="http://www.lib.ncsu.edu/" itemprop="url"><span itemprop="name">North Carolina State University Libraries</span></a></span>. 
      
      Feel free to contact me about this tutorial or microdata and schema.org
      generally, at <span itemprop="email">jronallo@gmail.com</span>.
    </p>
  
Follow
the steps below to move through the tutorial and learn about features of 
Microdata and Schema.org. As you go along, you will discover relevant tools. 
When there are still outstanding
questions about how to implement something in either microdata or schema.org,
there will be links to relevant discussions. Microdata is a new standard and 
schema.org a new vocabulary, so there are many points still being worked out.


At the top of the page for each step will be the markup for a page about a
photograph. Scroll down to find the information about the current step.
