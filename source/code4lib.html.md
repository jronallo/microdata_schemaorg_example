HTML5 Microdata and Schema.org
==============================

On June 2, 2011 [Bing](http://www.bing.com/community/site_blogs/b/search/archive/2011/06/02/bing-google-and-yahoo-unite-to-build-the-web-of-objects.aspx), 
[Google](http://googleblog.blogspot.com/2011/06/introducing-schemaorg-search-engines.html ), 
and 
[Yahoo](http://developer.yahoo.com/blogs/ydn/posts/2011/06/introducing-schema-org-a-collaboration-on-structured-data/ ) 
announced the joint effort [Schema.org](http://schema.org). When the big search
engines talk, web site authors listen. This article is an introduction
to Microdata and Schema.org. 
The tutorial will lead you through implementing these new technologies on a 
site for discovery of cultural heritage materials.
Along the way, you will be introduced to some tools for implementers and some
issues with applying this to cultural heritage materials.

HTML5
-----

The [HTML5 standard](http://www.w3.org/TR/html5/) 
(or [HTML Living Standard](http://www.whatwg.org/specs/web-apps/current-work/multipage/), 
depending on who you ask) has brought a lot of changes to web authoring.
Amongst all the buzz about HTML5 (some of which is not even part of the HTML spec),
HTML5 Microdata, a new semantic markup syntax that *is* part of the HTML standard,
often went overlooked. HTML elements often have
some semantics. For example, an `ol` element is an ordered list, and by default
gets rendered with numbers for the list items. 
With HTML5 we also have new semantic elements 
like `header`, `nav`, `article`, and `footer` that allow more expressiveness for 
page authors. A bunch of `div`s with various class names 
is no longer the way to divide up much content. These new elements also
allow web browser plugins to pull out the article for a cleaner reading 
experience, or search engines to give more weight to the `article` content 
rather than the advertising sidebar.

While these new elements provide useful extra information about the content, 
they provide no deeper understanding of what the `article` is *about*. 
In many cases you are probably
using a nicely normalized relational database or an XML document with a lot of 
fielded information about your resources. Putting that information in HTML 
loses a lot of what you
already know. The trip from the database or XML into HTML results in lost meaning.
Maybe a human can read your field labels to understand your metadata, but
that meaning is lost on machines.

One Simple Solution
-------------------

One solution communicate more of this metadata is to provide an alternative 
representation of your data separate from the HTML representation. You could
even help with auto-detection of that content by providing an alternative link
in the `head` of your HTML document. 

Here's a simple [example](http://inkdroid.org/journal/2011/09/22/stepping-backwards/) 
of making RIS formatted citation data available:

    <link rel="alternate" type="application/x-research-info-systems" href="/search?q=cartoons&format=ris" />
 
The link provides the type of the alternative representation and a relative URL 
where it can be found.

This approach can work in many cases, but it has some problems.
Techniques like this do not use the visible content
of the HTML, so the consumers of your data have to know to look for this
particular invisible content.

Embedding Data in Markup
------------------------

The HTML representation is most visible to users, so it
is also the HTML code which gets the most attention from developers. 
Little-used, overlooked APIs or data feeds are easy to let go stale.
If the website goes down, you are likely to hear about it from multiple sources
at once. If the OAI-PMH gateway goes down, I am guessing that it would take longer
for you to find out about it. Hidden services and content are too easy to get
neglected. Data embedded in visible HTML helps keep the representations in sync.
This insight has lead to a number of different standards over time
which take the
approach of embedding structured data with the visible HTML content. Microdata
is just one of these approaches.

History of Structured Data in HTML
----------------------------------

Other efforts that came before Microdata have solved this same problem of marking
up the meaning of content. Of the main syntaxes used today,
[Microformats](http://microformats.org/) was an [early effort](http://lists.w3.org/Archives/Public/public-html-data-tf/2011Dec/0030.html)
to provide "a general approach
of using visible HTML markup to publish structured data to the web." 
Some Microformat
specifications like [hCard](http://microformats.org/wiki/hcard), 
[hCalendar](http://microformats.org/wiki/hcalendar), and 
[rel-license](http://microformats.org/wiki/rel-license) are in common use across
the web. Simply put, Microformats usually use the convention of standard class 
names to provide meaning on a web page. The latest version [microformats-2](http://microformats.org/wiki/microformats-2)
simplifies and harmonizes these conventions across specifications significantly.

A standard of the W3C, RDFa has the vision of 
"[Bridging the Human and Data Webs](http://www.w3.org/TR/xhtml-rdfa-primer/)".
The idea is to provide attributes and processing rules for embedding RDF, and
all of its graph-based, linked data goodness, in HTML. 
Implementing RDFa has been overly complex for many web developers. Google had
supported RDFa in some fashion since 2009, and over that time had discovered
a [large error rate](http://lists.w3.org/Archives/Public/public-vocabs/2011Oct/0113.html)
in the application of RDFa by webmasters. 
Simplicity is one of the main reasons for the search engines preferring 
Microdata over RDFa.
In part in
reaction to greater adoption of Microdata, a simplified profile of RDFa has been 
created. [RDFa Lite 1.1](http://www.w3.org/2010/02/rdfa/sources/rdfa-lite/Overview-src.html)
provides simpler authoring guidelines that 
[mirror more closely the syntax of Microdata](http://lists.w3.org/Archives/Public/public-html-data-tf/2011Nov/0070.html).

It also bears mentioning that in the library space, we have developed 
specifications which tried to solve similar problems of making structured data 
available to machines through HTML pages.
The [unAPI](http://unapi.info/) specification uses a microformat for 
exposing (through the [deprecated `abbr` method](http://microformats.org/wiki/value-class-pattern)) 
the presence of identifiers  
which may resolve to alternative formats through a service. 
[COinS](http://ocoins.info/) uses empty spans to make OpenURL context objects
available for autodiscovery by machines.

So what is Microdata?
---------------------

Microdata came out of a [long thread about incorporating RDFa in HTML5](http://www.jenitennison.com/blog/node/124).
Because RDFa simply was not going to be incorporated into HTML5, 
something else was needed to fill the gap.
Out of that thread and collected use cases [Ian "Hixie" Hickson](http://hixie.ch/),
the editor of the HTML5 specification,
showed the first work on Microdata on [May 10, 2009](http://lists.whatwg.org/htdig.cgi/whatwg-whatwg.org/2009-May/019681.html)
(the syntax has changed some since then).

In Microdata terms, the things being described are items. Each
item is made up of one or more key-value pairs.
The Microdata syntax is made up of attributes, only three new HTML
attributes are core to the data model:

* `itemscope` says that there is a new item
* `itemtype` specifies the type of item
* `itemprop` gives the item properties


 


