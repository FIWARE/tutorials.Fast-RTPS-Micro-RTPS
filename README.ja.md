[![FIWARE Banner](https://fiware.github.io/tutorials.Fast-RTPS-Micro-RTPS/img/fiware.png)](https://www.fiware.org/developers)

これは、ロボット技術や極端に制約のあるデバイスで使用される RTPS (Real Time Publish Subscribe) の [Fast-RTPS](https://eprosima-fast-rtps.readthedocs.io) および [Micro-RTPS](http://micro-rtps.readthedocs.io) の入門チュートリアルです。FIWARE プラットフォームのイネーブラは、この低レベルの通信には直接関与していませんが、ロボッ・デバイスを FIWARE システムに接続する前に、プロトコルの完全な理解が必要です。

このチュートリアルでは、[Docker](https://www.docker.com) コンテナから直接実行できる一連の演習を紹介していますが、HTTP コールは必要ありません。

# Contents

- [Fast-RTPSとは？](#what-is-fast-rtps)
- [Micro-RTPSとは？](#what-is-micro-rtps)
- [前提条件](#prerequisites)
  * [Docker](#docker)
  * [Cygwin](#cygwin)
- [起動](#start-up)
- [Fast-RTPS 入門](#introduction-to-fast-rtps)
  * [使用例](#example-usage)
    + [例を作成 (:one:st ターミナル)](#make-the-examples-onest-terminal)
    + [Fast-RTPS サブスクライバを起動 (:one:st ターミナル)](#start-the-fast-rtps-subscriber-onest-terminal)
    + [Fast-RTPS パブリッシャを起動 (:two:nd ターミナル)](#start-the-fast-rtps-publisher-twond-terminal)
- [マイクロRTPS 入門](#introduction-to-micro-rtps)
  * [使用例](#example-usage-1)
    + [Micro-RTPS エージェントを起動 (:one:st ターミナル)](#start-the-micro-rtps-agent-onest-terminal)
    + [Micro-RTPS サブスクライバを起動 (:two:nd ターミナル)](#start-the-micro-rtps-subscriber-twond-terminal)
    + [Micro-RTPS パブリッシャを起動 (:three:rd ターミナル)](#start-the-micro-rtps-publisher-threerd-terminal)
- [次のステップ](#next-steps)


<a name="what-is-fast-rtps"></a>
# Fast-RTPSとは？

[eProsima](http://www.eprosima.com/) [Fast-RTPS](https://eprosima-fast-rtps.readthedocs.io) は RTPS (Real Time Publish Subscribe) プロトコルの C ++ 実装で、Object Management Group (OMG) コンソーシアムによって定義され維持されている、UDP などの信頼できないトランスポートを通じたパブリッシャとサブスクライバ間の通信を提供します。RTPS はまた、OMG によって Data Distribution Service (DDS) 標準用に定義されたワイヤ相互運用性プロトコルです。eProsima Fast RTPS は、ほとんどのベンダー・ソリューションが DDS を実装するツールとして、または過去のバージョンの仕様を使用するツールとして実装されているため、スタンドアロンで最新のメリットを持っています。

このライブラリの主な機能の一部は次のとおりです :

* リアルタイム・アプリケーション用に構成可能なベスト・エフォート型で信頼性の高いパブリッシュ/サブスクライブ通信ポリシー
* 新しいアプリケーションがネットワークの他メンバによって自動的に検出されるように接続をプラグ・アンド・プレイします
* ネットワーク内の複雑でシンプルなデバイスで継続的な成長を可能にするモジュール性とスケーラビリティ
* 構成可能なネットワーク動作と互換性のあるトランスポート層 : 各展開のための最適なプロトコルとシステム入出力チャネルの組み合わせを選択します
* 2つの API レイヤー : ユーザビリティに重点を置いた高水準のパブリッシャ/サブスクライバと、RTPS プロトコルの内部動作に細かいアクセスを提供するより低いレベルのライタ・リーダーです

eProsima Fast RTPS は、これらの重要なケースを含む多くの分野で複数の組織によって採用されています :

* ロボティクス : ROS2 のデフォルト・ミドルウェアとしての ROS (Robotic Operating System)
* EU R&D: FIWARE Incubated GE

<a name="what-is-micro-rtps"></a>
# Micro-RTPS とは？

RTPS (Real Time Publish Subscribe) 用の [eProsima](http://www.eprosima.com/) [Micro-RTPS](http://micro-rtps.readthedocs.io) プロトコルは、ロボティクスや非常に制約の厳しいデバイスで使用されています。これは、非常に限られたリソース制約環境 (eXtremely Resource Constrained Environments : XRCEs) と DDS ネットワーク間のパブリッシャとサブスクライバの通信を提供するソフトウェア・ソリューションです。特に、Micro-RTPS は、リソース制約のあるデバイス (クライアント) が DDS 通信に参加できるようにするクライアント/サーバのプロトコルを実装しています。Micro-RTPS エージェント (サーバ) は、Micro-RTPS クライアントに代わって動作し、DDS グローバル・データ・スペース内の DDS パブリッシャおよび/またはサブスクライバとして参加できるようにして、この通信を可能にします。

<a name="prerequisites"></a>
# 前提条件

<a name="docker"></a>
## Docker

物事を単純にするために、両方のコンポーネントが [Docker](https://www.docker.com) を使用して実行されます。**Docker** は、さまざまコンポーネントをそれぞれの環境に分離することを可能にするコンテナ・テクノロジです。

* Docker Windows にインストールするには、[こちら](https://docs.docker.com/docker-for-windows/)の手順に従ってください
* Docker Mac にインストールするには、[こちら](https://docs.docker.com/docker-for-mac/)の手順に従ってください
* Docker Linux にインストールするには、[こちら](https://docs.docker.com/install/)の手順に従ってください

**Docker Compose** は、マルチコンテナ Docker アプリケーションを定義して実行するためのツールです。[YAML file](https://raw.githubusercontent.com/Fiware/tutorials.Getting-Started/master/docker-compose.yml) ファイルは、アプリケーションのために必要なサービスを設定する使用されています。つまり、すべてのコンテナ・サービスは1つのコマンドで呼び出すことができます。Docker Compose は、デフォルトで Docker for Windows とDocker for Mac の一部としてインストールされますが、Linux ユーザは[ここ](https://docs.docker.com/compose/install/)に記載されている手順に従う必要があります。

<a name="cygwin"></a>
## Cygwin 

シンプルな bash スクリプトを使用してサービスを開始します。Windows ユーザは [cygwin](http://www.cygwin.com/) をダウンロードして、Windows 上の Linux ディストリビューションと同様のコマンドライン機能を提供する必要があります。

<a name="start-up"></a>
# 起動

インストールを開始するには、次の手順を実行します :

```console
git clone git@github.com:Fiware/tutorials.Fast-RTPS-Micro-RTPS.git

./services create
``` 

>**注** Docker イメージの最初の作成には最大15分かかります


その後、リポジトリ内で提供される [services](https://github.com/Fiware/tutorials.Fast-RTPS-Micro-RTPS/blob/master/services) Bash スクリプトを実行することによって、コマンドラインからすべてのサービスを初期化することができます :

```console
./services start
``` 

>:information_source: **注 :** クリーンアップをやり直したい場合は、次のコマンドを使用して再起動することができます :
>
>```console
>./services stop
>``` 
>

<a name="introduction-to-fast-rtps"></a>
# Fast-RTPS 入門

このセクションの目的は、Fast-RTPS をインストールして使用する方法に関する簡単なスタート・ガイドを提供することです。以降のチュートリアルでは、FIROS2 を使用して Fast-RTPS そして ROS2 を Orion Context Broker に接続する方法について説明します。

<a name="example-usage"></a>
## 使用例

この時点で、Docker コンテナ環境に Fast-RTPS がインストールされています。**Hello World** の例を実行できるようになりました。この例では、図に示すように、Fast-RTPS プロトコルを使用してパブリッシャからサブスクライバに一連のメッセージを送信します。

![](https://fiware.github.io/tutorials.Fast-RTPS-Micro-RTPS/img/fast-rtps-schema.png)


<a name="make-the-examples-onest-terminal"></a>
### 例を作成 (:one:st ターミナル)

新しいターミナルを開き、実行中の `examples-fast-rtps` の Docker コンテナで次のように入力します :

```console
docker exec -ti examples-fast-rtps /bin/bash
```

この例をコンパイルするには、以下のようにします :

```console
cmake . 
make 
make install
```

<a name="start-the-fast-rtps-subscriber-onest-terminal"></a>
### Fast-RTPS サブスクライバを起動 (:one:st ターミナル)

最初にサブスクライバを起動します :

```console
./HelloWorldExample subscriber
```

#### :one:st ターミナル - 結果 :

Fast-RTPS サブスクライバが起動し、メッセージを待っています :

```
Starting 
Subscriber running. Please press enter to stop the Subscriber
```

<a name="start-the-fast-rtps-publisher-twond-terminal"></a>
### Fast-RTPS パブリッシャを起動 (:two:nd ターミナル)

**2番目の新しいターミナル**を開き、実行中の `examples-fast-rtps` の Docker コンテナで次のように入力します :

```console
docker exec -ti examples-fast-rtps /bin/bash
```

次に、この2番目のターミナルでパブリッシャを起動します :

```console
./HelloWorldExample publisher
```

メッセージは、パブリッシャによって自動的に送信され、サブスクライバが受信する必要があります。すべてが正常であれば、パブリッシャ・ターミナルとサブスクライバ・ターミナルのそれぞれに次のような表示が表示されます :


#### :one:st ターミナル - 結果 :

Fast-RTPS サブスクライバは一連のメッセージを受信しました :

```
Subscriber matched
Message HelloWorld 1 RECEIVED
Message HelloWorld 2 RECEIVED
Message HelloWorld 3 RECEIVED
Message HelloWorld 4 RECEIVED
Message HelloWorld 5 RECEIVED
Message HelloWorld 6 RECEIVED
Message HelloWorld 7 RECEIVED
Message HelloWorld 8 RECEIVED
Message HelloWorld 9 RECEIVED
Message HelloWorld 10 RECEIVED
Subscriber unmatched
```

#### :two:nd ターミナル - 結果 :

Fast-RTPS パブリッシャは一連のメッセージを送信します :

```
Starting 
Publisher matched
Message: HelloWorld with index: 1 SENT
Message: HelloWorld with index: 2 SENT
Message: HelloWorld with index: 3 SENT
Message: HelloWorld with index: 4 SENT
Message: HelloWorld with index: 5 SENT
Message: HelloWorld with index: 6 SENT
Message: HelloWorld with index: 7 SENT
Message: HelloWorld with index: 8 SENT
Message: HelloWorld with index: 9 SENT
Message: HelloWorld with index: 10 SENT
```

:one:st ターミナルで、`<enter>` を押すことにより Fast-RTPS サブスクライバを停止できます。

コンテナから出て、インタラクティブ・モードを終了するには、各ターミナルで次のコマンドを実行します :

```console
exit
```
その後、コマンドラインに戻ります。

その他の例は `examples` フォルダにありますが、このチュートリアルの範囲を超えています。詳細については、[Fast-RTPS の公式ドキュメント](http://eprosima-fast-rtps.readthedocs.io/en/latest/)を参照してください。

<a name="introduction-to-micro-rtps"></a>
# Micro-RTPS 入門

このセクションの目的は、Micro-RTPS をインストールして使用する方法に関する簡単なスタート・ガイドを提供することです。

<a name="example-usage-1"></a>
## 使用例

この時点で、Micro-RTPS が Docker コンテナ環境にインストールされています。**Hello World** の例を実行できるようになりました。この例では、図に示すように、Micro-RTPS パブリッシャから Micro-RTPS エージェントを介して Micro-RTPS サブスクライバに一連のメッセージを送信します。

![](https://fiware.github.io/tutorials.Fast-RTPS-Micro-RTPS/img/micro-rtps-schema.png)


<a name="start-the-micro-rtps-agent-onest-terminal"></a>
### Micro-RTPS エージェントを起動 (:one:st ターミナル)

新しいターミナルを開き、実行中の `examples-micro-rtps` の Docker コンテナで次のように入力します :

```console
docker exec -ti examples-micro-rtps /bin/bash
```

まず、Micro-RTPS パブリッシャから送信されたメッセージを受信してサブスクライバに転送する Micro-RTPS エージェントを起動する必要があります。これを行うには、次のコマンドを実行します。これにより、Micro-RTPS エージェントが UDP ポート `2018` で起動されます :

```console
cd /usr/local/bin
MicroRTPSAgent udp 2018
```

#### :one:st ターミナル - 結果 :

Micro-RTPS エージェントが起動し、稼動しています :

```
UDP agent initialization... OK
Running DDS-XRCE Agent...
```

今度は、Docker 環境にさらに2つのターミナルが必要になります。ターミナルの1つでは、Micro-RTPS パブリッシャを開始し、もう1つはサブスクライバを開始します。2番目および3番目のターミナルを開くには、2つの bash ターミナルを開き、両方とも以下を実行します :

<a name="start-the-micro-rtps-subscriber-twond-terminal"></a>
### Micro-RTPS サブスクライバを起動 (:two:nd ターミナル)

**2番目の新しいターミナル**を開き、実行中の `examples-micro-rtps` の Docker コンテナで次のように入力します :

```console
docker exec -ti examples-micro-rtps /bin/bash
```

次のようにサブスクライバを起動します :

```console
cd /usr/local/examples/micrortps/SubscribeHelloWorldClient/bin/
./SubscribeHelloWorldClient udp 127.0.0.1 2018
```

#### :two:nd ターミナル - 結果 :

Micro-RTPS サブスクライバが実行され、メッセージを待っています :

```
<< UDP mode => ip: 127.0.0.1 - port: 2018 >>
```

<a name="start-the-micro-rtps-publisher-threerd-terminal"></a>
### Micro-RTPS パブリッシャ を起動 (:three:rd ターミナル)

**3番目の新しいターミナル**を開き、実行中の `examples-micro-rtps` の Docker コンテナで次のように入力します :

```console
docker exec -ti examples-micro-rtps /bin/bash
```

次に、3番目のターミナルでパブリッシャを起動します :

```console
cd /usr/local/examples/micrortps/PublishHelloWorldClient/bin/
./PublishHelloWorldClient udp 127.0.0.1 2018
```

メッセージは、パブリッシャによって自動的に送信され、サブスクライバが受信する必要があります。すべてが正常であれば、パブリッシャのターミナルとサブスクライバのターミナルのそれぞれに次のような表示が表示されます :


#### :one:st ターミナル - 結果 :

Micro-RTPS エージェントがパブリッシャからのメッセージの受信を開始しました :

```
UDP agent initialization... OK
Running DDS-XRCE Agent...
RTPS Publisher matched
...
```

#### :two:nd ターミナル - 結果 :

Micro-RTPS サブスクライバは、Micro-RTPS エージェントによって渡されたメッセージを受信しました :

```
<< UDP mode => ip: 127.0.0.1 - port: 2018 >>
Receive topic: Hello DDS world!, count: 1
Receive topic: Hello DDS world!, count: 2
Receive topic: Hello DDS world!, count: 3
Receive topic: Hello DDS world!, count: 4
Receive topic: Hello DDS world!, count: 5
Receive topic: Hello DDS world!, count: 6
Receive topic: Hello DDS world!, count: 7
Receive topic: Hello DDS world!, count: 8
...
```

#### :three:rd ターミナル - 結果 :

Micro-RTPS パブリッシャは、次のように一連のメッセージを送信しました :

```
<< UDP mode => ip: 127.0.0.1 - port: 2018 >>
Send topic: Hello DDS world!, count: 1
Send topic: Hello DDS world!, count: 2
Send topic: Hello DDS world!, count: 3
Send topic: Hello DDS world!, count: 4
Send topic: Hello DDS world!, count: 5
Send topic: Hello DDS world!, count: 6
Send topic: Hello DDS world!, count: 7
Send topic: Hello DDS world!, count: 8
...
```

コンテナから出て、インタラクティブ・モードを終了するには、次のコマンドを実行します :

```console
exit
```
その後、コマンドラインに戻ります。

その他の例は `examples` フォルダにありますが、このチュートリアルの範囲を超えています。詳細については、[Micro-RTPS の公式ドキュメント](http://micro-rtps.readthedocs.io/en/latest/)を参照してください。

<a name="next-steps"></a>
# 次のステップ

高度な機能を追加することで、アプリケーションに複雑さを加える方法を知りたいですか？このシリーズの他のチュートリアルを読むことで見つけることができます :

&nbsp; 101. [Getting Started](https://github.com/Fiware/tutorials.Getting-Started)<br/>
&nbsp; 102. [Entity Relationships](https://github.com/Fiware/tutorials.Entity-Relationships)<br/>
&nbsp; 103. [CRUD Operations](https://github.com/Fiware/tutorials.CRUD-Operations)<br/>
&nbsp; 104. [Context Providers](https://github.com/Fiware/tutorials.Context-Providers)<br/>
&nbsp; 105. [Altering the Context Programmatically](https://github.com/Fiware/tutorials.Accessing-Context)<br/> 
&nbsp; 106. [Subscribing to Changes in Context](https://github.com/Fiware/tutorials.Subscriptions)<br/>

&nbsp; 201. [Introduction to IoT Sensors](https://github.com/Fiware/tutorials.IoT-Sensors)<br/>
&nbsp; 202. [Provisioning an IoT Agent](https://github.com/Fiware/tutorials.IoT-Agent)<br/>
&nbsp; 203. [IoT over MQTT](https://github.com/Fiware/tutorials.IoT-over-MQTT)<br/>
&nbsp; 250. [Introduction to Fast-RTPS and Micro-RTPS ](https://github.com/Fiware/tutorials.Fast-RTPS-Micro-RTPS)<br/>

&nbsp; 301. [Persisting Context Data (Mongo-DB, MySQL, PostgreSQL)](https://github.com/Fiware/tutorials.Historic-Context)<br/>
&nbsp; 302. [Querying Time Series Data (Mongo-DB)](https://github.com/Fiware/tutorials.Short-Term-History)<br/>
&nbsp; 303. [Querying Time Series Data (Crate-DB)](https://github.com/Fiware/tutorials.Time-Series-Data)<br/>
