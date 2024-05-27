##  离开和进入html页面时改变title

**原理：**

使用了HTML5的Page Visibility API

目前页面可见性API有两个属性，一个事件，如下：

document.hidden: Boolean值，表示当前页面可见还是不可见

document.visibilityState: 返回当前页面的可见状态，取值有 hidden visible prerender preview

visibilitychange: 当可见状态改变时候触发的事件







```js
    var OriginTitile = document.title;
    var titleTime;
    document.addEventListener('visibilitychange', function() {
        if (document.hidden) {
            document.title = '(つェ⊂)我藏好了哦~ ' + OriginTitile;
            clearTimeout(titleTime);
        }
        else {
            document.title = '(*´∇｀*) 被你发现啦~ ' + OriginTitile;
            titleTime = setTimeout(function() {
                document.title = OriginTitile;
            }, 2000);
        }
    });
```