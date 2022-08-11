// このファイルは、Webpackによって自動的にコンパイルされます。
// このディレクトリに存在する他のファイルと一緒に。実際のアプリケーションロジックは、app/javascript内の関連する構造体に置くことをお勧めします。
// app/javascript 内の関連する構造体に配置し、これらの pack ファイルはそのコードを参照するためにのみ使用することをお勧めします。
// コンパイルされるように、そのコードを参照するためにのみ、これらのパックファイルを使用することをお勧めします。

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

// 必要なJavaScriptファイルをrequireまたはimportする
import "bootstrap"
// import "/myapp/app/assets/stylesheets/custom.scss"
import "../stylesheets/application.scss";
Rails.start()
Turbolinks.start()
ActiveStorage.start()
require("jquery")