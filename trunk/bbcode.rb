#! /usr/bin/env ruby
module BBCode
	@@imageformats = 'png|bmp|jpg|gif'
	@@tags = {
		# tag name => [regex, replace, description, example]
		'Bold' => [
			/\[b\](.*?)\[\/b\]/m,
			'<strong>\1</strong>',
			'Embolden text',
			'Look [b]here[/b]'],
		'Italics' => [
			/\[i\](.*?)\[\/i\]/m,
			'<em>\1</em>',
			'Italicize or emphasize text',
			'Even my [i]cat[/i] was chasing the mailman!'],
		'Underline' => [
			/\[u\](.*?)\[\/u\]/,
			'<u>\1</u>',
			'Underline',
			'Use it for [u]important[/u] things or something'],
		'Strikeout' => [
			/\[s\](.*?)\[\/s\]/,
			'<s>\1</s>',
			'Strikeout',
			'[s]nevermind[/s]'],
		
		'Delete' => [
			/\[del\](.*?)\[\/del\]/,
			'<del>\1</del>',
			'Deleted text',
			'[del]deleted text[/del]'],
		'Insert' => [
			/\[ins\](.*?)\[\/ins\]/,
			'<ins>\1</ins>',
			'Inserted Text',
			'[ins]inserted text[/del]'],
		
		'Ordered List' => [
			/\[ol\](.*?)\[\/ol\]/m,
			'<ol>\1</ol>',
			'Ordered list',
			'My favorite people (alphabetical order): [ol][li]Jenny[/li][li]Alex[/li][li]Beth[/li][/ol]'],
		'Unordered List' => [
			/\[ul\](.*?)\[\/ul\]/m,
			'<ul>\1</ul>',
			'Unordered list',
			'My favorite people (order of importance): [ul][li]Jenny[/li][li]Alex[/li][li]Beth[/li][/ul]'],
		'List Item' => [
			/\[li\](.*?)\[\/li\]/,
			'<li>\1</li>',
			'List item',
			'See ol or ul'],
		'List Item (alternative)' => [
			/\[\*\](.*?)$/,
			'<li>\1</li>'],
		
		'Definition List' => [
			/\[dl\](.*?)\[\/dl\]/m,
			'<dl>\1</dl>',
			'List of terms/items and their definitions',
			'[dl][dt]Fusion Reactor[/dt][dd]Chamber that provides power to your... nerd stuff[/dd][dt]Mass Cannon[/dt][dd]A gun of some sort[/dd][/dl]'],
		'Definition Term' => [
			/\[dt\](.*?)\[\/dt\]/,
			'<dt>\1</dt>'],
		'Definition Definition' => [
			/\[dd\](.*?)\[\/dd\]/,
			'<dd>\1</dd>'],
		
		'Link' => [
			/\[url=(.*?)\](.*?)\[\/url\]/,
			'<a href="\1">\2</a>',
			'Hyperlink to somewhere else',
			'Maybe try looking on [url=http://google.com]Google[/url]?'],
		'Link (Implied)' => [
			/\[url\](.*?)\[\/url\]/,
			'<a href="\1">\1</a>'],
		# I'll fix this later or something
#		'Link (Automatic)' => [
#			/http:\/\/(.*?)[^<\/a>]/,
#			'<a href="\1">\1</a>'],
		
		'Image' => [
			/\[img\]([^\[\]].*?)\.(#{@@imageformats})\[\/img\]/i,
			'<img src="\1.\2" alt="" />',
			'Display an image',
			'Check out this crazy cat: [img]http://catsweekly.com/crazycat.jpg[/img]'],
		'Image (Alternative)' => [
			/\[img=([^\[\]].*?)\.(#{@@imageformats})\]/i,
			'<img src="\1.\2" alt="" />']
	}
	def self.to_html(text)
		@@tags.each_value { |t|
			text.gsub!(t[0], t[1])
		}
		text
	end
	def self.tags
		@@tags.each { |tn, ti|
			# yields the tag name, a description of it and example
			yield tn, ti[2], ti[3] if ti[2]
		}
	end
end

class String
	def bbcode_to_html()
		BBCode.to_html(self)
	end
	def bbcode_to_html!()
		self.replace(BBCode.to_html(self))
	end
end