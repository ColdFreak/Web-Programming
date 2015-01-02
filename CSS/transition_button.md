```
<!DOCTYPE html>
<html>
    <head>
    </head>

    <body>
        <div id="menubar1">
            <a href="#">Home</a><a href="#">About us</a><a href="#">Service</a><a href="#">Staff</a><a href="#">Contact</a>

        </div>
    </body>
</html>
```

![](/Users/wang/Desktop/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88%202015-01-02%2018.14.49.png)

----
バックグラウンドを黒にしてから、marginを０にします。

```
<html>
    <head>
    <style>
    body {
    	background: #000;
    	margin: 0;
    }
    </style>
    </head>

    <body>
        <div id="menubar1">
            <a href="#">Home</a><a href="#">About us</a><a href="#">Service</a><a href="#">Staff</a><a href="#">Contact</a>

        </div>
    </body>
</html>
```

![](/Users/wang/Desktop/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88%202015-01-02%2018.19.22.png)

---

id="menubar1"のdivタグにpadding 24pxをつけて、点線を表示させます。

```
<!DOCTYPE html>
<html>
    <head>
    <style>
    body {
    	background: #000;
    	margin: 0;
    }
    div#menubar1 {
    	padding: 24px;
    	border: #999 1px dashed;
    }
    </style>
    </head>

    <body>
        <div id="menubar1">
            <a href="#">Home</a><a href="#">About us</a><a href="#">Service</a><a href="#">Staff</a><a href="#">Contact</a>

        </div>
    </body>
</html>

```

![](/Users/wang/Desktop/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88%202015-01-02%2018.25.23.png)

---



```
<!DOCTYPE html>
<html>
    <head>
    <style>
    body {
    	background: #000;
    	margin: 0;
    }
    div#menubar1 {
    	padding: 24px;
    	border: #999 1px dashed;
    }
    div#menubar1 > a {
    	font-family: Arial, Helvetica, sans-serif;
    	font-size: 17px;
    	color: #999;
    	background: #333;
    	padding: 12px 24px;
    }
    </style>
    </head>

    <body>
        <div id="menubar1">
            <a href="#">Home</a><a href="#">About us</a><a href="#">Service</a><a href="#">Staff</a><a href="#">Contact</a>

        </div>
    </body>
</html>

```