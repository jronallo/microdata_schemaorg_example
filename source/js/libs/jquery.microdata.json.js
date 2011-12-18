/* -*- mode: js; js-indent-level: 2; indent-tabs-mode: nil -*- */

/*
 * © 2009-2011 Philip Jägenstedt
 * 
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
*/

'use strict';

// http://www.whatwg.org/specs/web-apps/current-work/multipage/microdata.html#json
jQuery.microdata.json = function(selector, format) {
  var $ = jQuery;

  function getObject(item, memory) {
    var $item = $(item);
    var result = {};
    var types = $item.itemType();
    if (types.length)
      result.type = $(types).toArray();
    if ($item.itemId())
      result.id = $item.itemId();
    result.properties = {};
    $item.properties().each(function(i, elem) {
      var $elem = $(elem);
      var value;
      if ($elem.itemScope()) {
        if ($.inArray(elem, memory) != -1) {
          value = 'ERROR';
        } else {
          memory.push(item);
          value = getObject(elem, memory);
          memory.pop();
        }
      } else {
        value = $elem.itemValue();
      }
      $.each($elem.itemProp(), function(i, prop) {
        if (!result.properties[prop])
          result.properties[prop] = [];
        result.properties[prop].push(value);
      });
    });
    return result;
  }

  var result = {};
  result.items = [];
  var $items = selector ? $(selector) : $(document).items();
  $items.each(function(i, item) {
    var $item = $(item);
    if ($item.itemScope())
      result.items.push(getObject(item, []));
  });
  return format ? format(result) : JSON.stringify(result);
};
