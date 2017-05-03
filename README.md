# ThemeEngine
A theme engine for iOS app. Just a demo by now.



## Theme Format

Theme styles are described in **JSON** format, like this:

```json
{
  "item1": {
    "bgcolor": "#333333",
    "alpha": 0.5
  },
  "item2": {
    "bgcolor": "#eeeeee",
    "fgcolor": "#111111"
  },
  "item1 item2": {
     "bgcolor": "#333333",
  }
}
```

It's something like a lite version css, with a much simpler **selector**:

For example, there is an UI element with style chain: ["a", "b", "c"], It can hit styles (priority from high to low):

- c
-  c b
-  c b a
-  c a
-  b
-  b a
-  a

The last name has the highest priority.