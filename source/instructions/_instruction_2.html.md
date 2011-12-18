### 2. adding ItemPage

When using the schema.org vocabularies, every page is implicitly assumed to be 
some kind of [WebPage](http://schema.org/WebPage), but the advice is to 
explicitly declare the type of page. One of the main uses of defining a WebPage
is to specify values for a `breadcrumb` property.

For a show view of a single photograph it seems appropriate to use [ItemPage](http://schema.org/ItemPage).
ItemPage
adds no new properties to WebPage, but it communicate to the search engines that
the page refers to a single item rather than a search results page.
"A page devoted to a single item, such as a particular product or hotel."
I have no proof for this yet, but the assumption is that assigning an `itemtype`
of ItemPage gives the search engines an extra hint that the page should be
indexed.

Further, Ian Hickson the editor of the Microdata specification, has said that
with microdata one is always describing a page. This is a rather different way
of thinking about embedded structured data in HTML from RDFa. Microdata isn't
so much linked data as it is a description of a single page. YKKK

Currently, there are no properties for the ItemPage.
You can use the inspector in your browser to search for `itemtype` and `itemscope`
and see that we've applied it here to the `html` element.

There is [some uncertainty](YKK) as to where one should place the `itemtype` 
attribute for an ItemPage. Should it be applied to the `html` element or the 
`body`?

Below we begin to see that some microdata is able to be extracted from this page. 
This display uses the [MicrodataJS library](https://gitorious.org/microdatajs/) 
created by Philip Jägenstedt. This same library powers [Live Microdata](http://foolip.org/microdatajs/live/)
which is a great tool for testing snippets of HTML with microdata. MicrodataJS
library is actually a javascript implementation of 

One of the interesting features of the Microdata specification is the [JSON API](YKK).
Microdata was created to be easily parsed with simple rules into a JSON serialization.
Because of this built-in serialization to JSON, some desired changes to the 
microdata spec, like [specifying the language of a value](YKK), are not impossible, but
are more difficult.

