# ImageRenderDemo
iOS-从UIImage渲染模式到UI渲染性能优化
大致内容：

UIImage渲染模式 imageWithRenderingMode:

UIImage新增了一个只读属性：renderingMode，对应的还有一个新增方法：imageWithRenderingMode:，它使用UIImageRenderingMode枚举值来设置图片的renderingMode属性。该枚举中包含下列值：

UIImageRenderingModeAutomatic 

// 根据图片的使用环境和所处的绘图上下文自动调整渲染模式。

UIImageRenderingModeAlwaysOriginal 

// 始终绘制图片原始状态，不使用Tint Color。 

UIImageRenderingModeAlwaysTemplate 

// 始终根据Tint Color绘制图片，忽略图片的颜色信息。
说到图片渲染，顺便说一下UI渲染的相关优化：

1、Color Blended Layers

2、Color Copied Images

3、Color Misaligned Images

4、Color Offscreen-Rendered

圆角优化

shadow优化

其他的一些优化建议

当我们需要圆角效果时，可以使用一张中间透明图片蒙上去

使用ShadowPath指定layer阴影效果路径

使用异步进行layer渲染（Facebook开源的异步绘制框架AsyncDisplayKit）

设置layer的opaque值为YES，减少复杂图层合成

尽量使用不包含透明（alpha）通道的图片资源

尽量设置layer的大小值为整形值

直接让美工把图片切成圆角进行显示，这是效率最高的一种方案

很多情况下用户上传图片进行显示，可以让服务端处理圆角

使用代码手动生成圆角Image设置到要显示的View上，利用UIBezierPath（CoreGraphics框架）画出来圆角图片

详情介绍见云笔记：
http://note.youdao.com/noteshare?id=773948c7fb043091ea4b270620e1d0f6
