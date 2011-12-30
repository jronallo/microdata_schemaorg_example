HTML5 Microdata and Schema.org
==============================

On June 2, 2011 [Bing](http://www.bing.com/community/site_blogs/b/search/archive/2011/06/02/bing-google-and-yahoo-unite-to-build-the-web-of-objects.aspx), 
[Google](http://googleblog.blogspot.com/2011/06/introducing-schemaorg-search-engines.html ), 
and 
[Yahoo](http://developer.yahoo.com/blogs/ydn/posts/2011/06/introducing-schema-org-a-collaboration-on-structured-data/ ) 
announced the joint effort [Schema.org](http://schema.org). When the big search
engines talk, web site authors listen. 

This is an introduction to Microdata and Schema.org. 
The tutorial will lead you through implementing these new technologies on a 
site for discovery of cultural heritage materials.
Along the way, you will be introduced to some tools for implementers and some
issues with applying this to cultural heritage materials.

Foundation
----------

### HTML5

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

### One Simple Solution

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

### Embedding Data in Markup

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
is just one of the syntaxes in use today.

### History of Structured Data in HTML

Other efforts that came before Microdata have solved this same problem of marking
up the meaning of content. Of the main syntaxes used today,
[Microformats](http://microformats.org/) was not the first but was
an [early effort](http://lists.w3.org/Archives/Public/public-html-data-tf/2011Dec/0030.html)
to provide "a general approach
of using visible HTML markup to publish structured data to the web." 
Some Microformat
specifications like [hCard](http://microformats.org/wiki/hcard), 
[hCalendar](http://microformats.org/wiki/hcalendar), and 
[rel-license](http://microformats.org/wiki/rel-license) are in common use across
the web. Development of the various small Microformat standards take place on 
a community wiki.
Simply put, Microformats usually use the convention of standard class 
names to provide meaning on a web page. The latest version [microformats-2](http://microformats.org/wiki/microformats-2)
simplifies and harmonizes these conventions across specifications significantly.

RDFa, a standard of the W3C, has the vision of 
"[Bridging the Human and Data Webs](http://www.w3.org/TR/xhtml-rdfa-primer/)."
The idea is to provide attributes and processing rules for embedding RDF (and
all of its graph-based, linked data goodness) in HTML. 
With all that expressive power comes some difficulty, and
implementing RDFa has been overly complex for most web developers. Google has
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

### So what is Microdata?

Microdata came out of a [long thread about incorporating RDFa in HTML5](http://www.jenitennison.com/blog/node/124).
Because RDFa simply was not going to be incorporated into HTML5, 
something else was needed to fill the gap.
Out of that thread and collected use cases [Ian "Hixie" Hickson](http://hixie.ch/),
the editor of the HTML5 specification,
showed the first work on Microdata on [May 10, 2009](http://lists.whatwg.org/htdig.cgi/whatwg-whatwg.org/2009-May/019681.html)
(the syntax has changed some since then). The syntax is designed to be simple
for page authors to implement.

In technical Microdata terms, the things being described are items. Each
item is made up of one or more key-value pairs.
The Microdata syntax is made up of attributes. Only three new HTML
attributes are core to the data model:

* `itemscope` says that there is a new item
* `itemtype` specifies the type of item
* `itemprop` gives the item properties

### A First Example

    <div itemscope itemtype="unorganization">
      <span itemprop="eponym">code4lib</span>
    </div>
    
The user of a browser would only see the text "code4lib".
The snippet provides more meaning for machines by asserting that there is an 
"unorganization" with the "eponym" "code4lib."

The `@itemscope` attribute creates an item and requires no value.
The `@itemtype` attribute asserts that the type of thing being described is an 
"unorganization."
The item has a single
key-value pair--the property "eponym" with a value of "code4lib."

To make it clear to someone who thinks in JSON, here is what the item looks
like:

    {
      "type": [
        "unorganization"
      ],
      "properties": {
        "eponym": [
          "code4lib"
        ]
      }
    }

Those are the only three attributes necessary for a complete understanding of the 
Microdata model. (You'll learn about two more optional ones later.) 
Pretty simple, right?

### What is Schema.org?

While the above snippet is completely valid Microdata,  
it uses arbitrary language for its `@itemtype` and `@itemprop` values. If you
live in your own little closed world, that may be just fine. But for the most
part you probably want other people's machines to understand the meaning of
your content. You need to use a shared language so that page authors and
consumers can cooperate on how to interpret the meaning.

This is where Schema.org comes in. Schema.org is a vocabulary. The search  
engines (Bing, Google, Yahoo) created Schema.org 
and have agreed to support and understand it. 
The domain it covers is broad, sometimes called a Web-scale vocabulary 
or ["middle" ontology](http://lists.w3.org/Archives/Public/public-vocabs/2011Nov/0006.html).
One goal of having such a broad schema all in one place is to 
[simplify things for mass adoption](http://blog.schema.org/2011/11/using-rdfa-11-lite-with-schemaorg.html?showComment=1321045329383#c3006481536068088400)
and cover the most common use cases.
You can browse the 
[full hierarchy of the vocabulary](http://schema.org/docs/full.html) to get a 
feel of the bounds of the world according to search engines. 

Schema.org defines a hierarchy of types descending from Thing. Thing has four
properties (description, image, name, url) which are inherited by other types.
Child types can add their own properites and have their own children types.
A property name with a particular meaning has that same meaning when found in
every type in the vocabulary.
We will get to other specifics as we go through a tutorial.

Microdata and Schema.org have a tight connection, though each can be used without
the other.
The search engines are currently the main consumers
of Schema.org data and have a stated preference for Microdata, which can be
seen through the Schema.org examples being written using the Microdata syntax.

Here's the above Microdata example rewritten to make more sense and
use the Schema.org [`Organization`](http://schema.org/Organization)
type.

    <div itemscope itemtype="http://schema.org/Organization">
      <span itemprop="name">code4lib</span>
    </div>

### Rich Snippets

The most obvious way that the search engines are currently using
Microdata is to be able to display rich snippets in search results. 
If you have done a Google search in the past two years, you have probably seen 
some examples of this.
You can see
good examples of how powerful this is by doing a [Google Recipe Search](http://www.google.com/landing/recipes/)
for "vegan cupcakes":

<p>
<img alt="Rich Snippet for Vegan Cupcakes" src="/images/vegan_cupcakes.png"/>
</p>

This search result snippet for a recipe includes an image, reviews, cooking 
time, calorie count, some of the text introducing the recipe, and a list of
some of the ingredients needed. This gives a lot more scent to the user for 
clicking on a particular result.
Snippets with this kind of extra information are
reported to [increase click through rates](http://www.heppresearch.com/gr4google). 

Google started presenting rich snippets [in 2009](http://googlewebmastercentral.blogspot.com/2009/05/introducing-rich-snippets.html). 
Using embedded markup like microformats, RDFa or Microdata, page authors 
can influence what could show up in a search result snippet.
Both [Microformats](http://support.google.com/webmasters/bin/answer.py?hl=en&answer=146897) 
and [RDFa](http://support.google.com/webmasters/bin/answer.py?hl=en&answer=146898) 
were promoted
for rich snippets in the past and continue to be supported. 
Google [added support for Microdata for Rich Snippets](http://googlewebmastercentral.blogspot.com/2010/03/microdata-support-for-rich-snippets.html) 
in early 2010. After RDFa Lite was created, the Schema.org partners agreed to
support that syntax as well.

Before Schema.org rich snippets were constrained in the types that would trigger
them. Reviews, products, and recipes were common types.
At the time of this writing there is still not support for all, or even most,
of the Schema.org types, but the number of supported types and example rich 
snippets has been slowly growing. The promise is that many more of the Schema.org
types will begin to trigger rich snippets.

Currently, the main reason to be using Microdata with Schema.org is that it is
the latest search-engine preferred method for exposing structured data in HTML.
While other consumers for structured data using Microdata and/or Schema.org may
appear in the future, the [most compelling uses cases](YKK Hixie on use cases) 
are currently for use by the search engines. By providing the search engines
with more data on your pages, it improves the search experience of users and 
can draw them to your site. Since most of the users of your site likely come
through the search engines, this could be a powerful way to draw more users
to your resources.

From a developer's perspective there are [many considerations](YKK) for 
choosing a particular syntax. Microdata has a natural fit with HTML and is
designed for simplicity and ease of implementation.

Tutorial
--------

This tutorial will lead you through implementing Microdata and Schema.org on
a pre-existing site for exposing digitized collections. The example is based on
[NCSU Libraries' Digital Collections: Rare and Unique Materials](http://d.lib.ncsu.edu/collections).
Each step will lead you through the decisions that are made and
the problems that are encounted in implementing Microdata and Schema.org.

### Before Microdata

Here's a screenshot of the page to mark up. As we add Microdata to the page,
it will continue to look exactly like this. The page uses a grid system to
place the image on the left and the metadata to the right.

Those students are excited to learn more about HTML5 Microdata and Schema.org!

<p>
<img alt="Screenshot of page for digital photograph" src="/images/bell_tower_screenshot.png"/>
</p>

Here is the basic structure of the main content of the page with 
some sections and attributes removed for brevity.

    <div id="main" class="container_12">
      <h2 id="page_name">
        Students jumping in front of Memorial Bell Tower
      </h2>
      <div class="grid_5">    
          <img id="main_image" alt="Students jumping in front of Memorial Bell Tower" src="/images/bell_tower.png">    
      </div>  
      <div id="metadata" class="grid_7">
        <div id="item" class="info">
          <h2>Photograph Information</h2>
          <dl>   
            ...         
          </dl> 
        </div><!-- item -->
        
        <div id="building" class="info">
          <h2>Building Information</h2>
          <dl>
            ...        
          </dl>      
        </div><!-- building -->
        
        <div id="source" class="info">
          <h2>Source Information</h2>
          <dl>
            ...
          </dl>     
        </div><!-- source -->
      </div>
    </div>


### Adding a WebPage

When using the schema.org vocabularies, every page is implicitly assumed to be 
some kind of [WebPage](http://schema.org/WebPage), but the [advice](YKK) is to 
explicitly declare the type of page. When we find an appropriate type, we will
want to choose the most specific type that could accurately represent the
thing we want to mark up. In this case it seems appropriate to use 
[ItemPage](http://schema.org/ItemPage). ItemPage
adds no new properties to WebPage, but it communicates to the search engines that
the page refers to a single item rather than a search results page.
I can find no proof for this yet, but it may be that using ItemPage will give
an extra hint to a crawler that a page should be indexed or treated differently. 
For the same reason, marking up a SearchResultsPage could give the hint to the
search engines to crawl but not index the page.

In some way when you are adding Microdata you are always just describing a web
page. Ian Hickson the editor of the Microdata specification, has said that
Microdata items exist "in the context of a page and its 
DOM. It does not have an independent existence outside the page." 
([Ian Hickson on public-vocabs list](http://lists.w3.org/Archives/Public/public-html-data-tf/2011Oct/0140.html).)
This is different than the way RDFa may think about embedded structured data in 
HTML. Microdata isn't
so much linked data as it is a description of a single page. 

Here we add the ItemPage to the `div#main` on the page and some properties
within. 

    <div id="main" class="container_12" itemscope="" itemtype="http:schema.org/ItemPage">
      <h2 id="page_name" itemprop="name">
        Students jumping in front of Memorial Bell Tower
      </h2>
      <div class="grid_5">    
          <img id="main_image" alt="Students jumping in front of Memorial Bell Tower" 
            src="/images/bell_tower.png" itemprop="image">    
      </div>  
      <div id="metadata" class="grid_7">
        ...
      </div>
    </div>

Here we apply the `itemscope` and `itemtype` attributes at a level in the DOM
that surrounds everything we want to describe about the page.
Since we are describing, the page, we could instead add the `itemscope` and
`itemtype` at a higher level. If we need to use some metadata in the `head` of
the document, say the `title` element, we could apply this to the `html`
element. YKK reports of some problems

Within `div#main` we add the two `itemprop`s for the "name" and "image"
properties. Different elements take their `itemprop` value from different
places. 
In this case the "name" property is taken from the text content of `h2` element.
For the `img` element the value is taken from the `src` attribute, which is
then resolved into an absolute URL. The `a` element uses the absolute URL
from the `href` attribute.
If you start using Microdata, you will want to consult 
[this list from the spec](http://www.whatwg.org/specs/web-apps/current-work/multipage/microdata.html#values)
which details how property values are determind for different elements.

### Microdata JSON

One of the cool features of Microdata is that it is designed to be 
[extracted into JSON](http://www.whatwg.org/specs/web-apps/current-work/multipage/microdata.html#json). 
 
YKK

### Microdata DOM API

Another neat feature is the [Microdata DOM API](http://www.whatwg.org/specs/web-apps/current-work/multipage/microdata.html#microdata-dom-api),
which allows you to extract Microdata client-side. 

You can test whether your browser implements the Microdata DOM API by running the
[microdata test suite](http://w3c-test.org/html/tests/submission/Opera/microdata/001.html) 
created by Opera. If
you open this page up in [Opera Next](http://www.opera.com/browser/next/) 
(at the time of this writing version 12.00 alpha, build 1191), go to this page,
and open up the console (Ctrl+Shift+i), you can play with the Microdata
DOM API a bit. 
`document.getItems()` will return a NodeList of all items. There is (and will be)
only one top-level item on this page, so the NodeList will contain only one
element. It is possible to get all items of a particular type by specifying the
type or types as an argument like `document.getItems('http://schema.org/ItemPage')`.
This API may change in the future 
["to match what actually gets implemented"](http://old.nabble.com/Re%3A-New-feature-announcement---Implement-HTML5-Microdata-in-WebKit-p32521849.html).


    >>> var itemPage = document.getItems('http://schema.org/ItemPage')
      undefined
    >>> itemPage
      NodeList [<html itemscope="" itemtype="http://schema.org/ItemPage" lang="en">]
    >>> itemPage[0].properties
      HTMLPropertiesCollection [<h2 id="page_name" itemprop="name">, 
        <img itemprop="image" id="main_image" alt="Students jumping in front of Memorial Bell Tower" src="/images/bell_tower.png"/>]





