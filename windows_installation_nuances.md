
[NOTE]: To remove ctrl+v paste behavior one should find settings.json for windows terminal and comment corresponding keybind

[NOTE]: Clang-fromat may require manual installation


##Temp

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
