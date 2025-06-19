![제목 없는 다이어그램 drawio (6)](https://github.com/user-attachments/assets/ef0f38de-3cbd-496c-9786-5433ce05b41c)
<h1 align="center" style="color: #50C878;"> OrderLabs 🌿</h1>


<br><br>




## 🧑🏻‍🌾 프로젝트 개요

<div>
  
  **"자라는 만큼만 주문받는다."** <br>
</div>

이 서비스는 농·수산물의 생육 상태나 생물의 건강 데이터를 기반으로 주문 가능 여부를 
자동 판단하고 관리하는 스마트 주문 관리 플랫폼입니다. 
기존의 단순 재고 기반 판매 방식과 달리, 생물의 생육데이터 여기서는 공공 데이터(예: 
기상정보, 생육 센서 데이터 등)와 실시간 수집된 생물 정보(예: 수산물 성장률, 건강도)를 
분석하여 언제 주문을 받을 수 있고, 언제 배송이 가능한지를 예측 및 자동 통제합니다. 
이를 통해 생산자는 재고 과잉이나 무리한 주문을 방지하고, 소비자는 더 신선하고 정확한 
일정으로 상품을 수령할 수 있습니다. 
생물은 자라야 팔 수 있습니다. 우리는 그 ‘자라는 과정’까지 주문 시스템에 담습니다.

<br><br>

## 🕵️ 팀원 소개

<div align="center">

|   <img src="https://avatars.githubusercontent.com/u/149382180?v=4" width="100" height="100"/>   |   <img src="https://avatars.githubusercontent.com/u/96688099?v=4" width="100" height="100"/>   | <img src="https://avatars.githubusercontent.com/u/195714592?v=4" width="100" height="100"/>  |  <img src="https://avatars.githubusercontent.com/u/92301360?v=4" width="100" height="100"/>  |    <img src="https://avatars.githubusercontent.com/u/201225844?v=4" width="100" height="100"/>      |
| :--------------------------------------------------------: | :--------------------------------------------------------: | :--------------------------------------------------------: | :------------------------------------------------------: | :----------------------------------------------------------: |
| 🐰 **양승우**<br/>[@atimaby28](https://github.com/miyad927) | 🧶 **이시욱**<br/>[@David9733](https://github.com/David9733) | ⚽ **구창모**<br/>[@kucha240](https://github.com/kucha240) | 🐢 **유현경**<br/>[@gaangstar](https://github.com/gaangstar) | 🐉 **윤소민**<br/>[@somminn](https://github.com/somminn) |

</div>
<br>

## 🔗요구 사항 명세서 바로가기
![요구사항2](./02_요구사항%20정의서.png)
<div align="center">
  <a href="https://docs.google.com/spreadsheets/d/1xPRM4gAtze_Mu-vF_rwFMtvYI7baOceUvJYlSDdcA-o/edit?gid=1400486362#gid=1400486362" target="_blank">
    📄 요구사항 정의서 바로가기
  </a>
</div>

<br><br>

## ☁️ ERD
![OrderLabs-erd](./03_ERD.png)
<div align=center>
  
  [🔗ERD CLOUD 바로가기](https://www.erdcloud.com/d/GjgSeJRtpNC9jNFpG)
</div>

<br><br>

## ⚙️ 시스템 아키텍처
<img width="1324" alt="전체" src="./04_Architecture.png">

<br><br>

<div align=center>
    저희는 데이터 서버를 6대를 구성하였고 <br>
    두 서버는 Replication, 세 서버는 Clustering 나머지 한 서버는 연산을 위한 전용 서버로 구성하였습니다.
</div>

<br><br>

<details>
  <summary>Why replication?</summary>
  <br>
    운영 서버는 단일 DB 장애 시 전체 서비스가 중단되는 것을 막기 위해 Data Replication을 사용했습니다. 예를 들어, Master-Slave 구조로 구성해서 Master 장애 시 Slave로 자동 전환(Failover)이 가능하도록 했습니다. 이를 통해 서비스의 가용성과 안정성을 최우선으로 하였습니다.
  <br>
</details>

<details>
  <summary>Why database clustering?</summary>
  <br>
    작물 상태나 온도, 습도, 일사량 등의 실시간 기상 데이터가 끊기면 자동화 시스템이 오작동할 수 있어, 클러스터로 장애 대비를 했습니다.

</details>

<details>
  <summary>Why Calculate database?</summary>
  <br>
    운영 DB에 부하를 주지 않고 분석 작업과 계산 작업을 수행하기 위해 별도의 데이터베이스를 사용했습니다. 시계열 데이터를 다룬다는 점과 집계 쿼리를 반복 수행하기 위해, 운영 서비스 성능에 영향을 주지 않도록 했습니다.

</details>

<h2>📌 구축 쿼리 (DDL)</h2>

<details><summary> 🙆 사용자 테이블</summary><div dir="auto">
  <div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    email VARCHAR(20) NOT NULL UNIQUE,
    birth_date DATETIME NOT NULL, 
    phone_number VARCHAR(13) UNIQUE,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    home_number VARCHAR(20) UNIQUE,
    address VARCHAR(50) NOT NULL,
    role ENUM('일반 사용자', '생산자') NOT NULL,
    password_hash VARCHAR(100) NOT NULL
);">
<pre><span class="pl-k">CREATE</span> <span class="pl-k">TABLE</span> <span class="pl-en">users</span> (
    id <span class="pl-k">BIGINT</span> <span class="pl-k">AUTO_INCREMENT</span> <span class="pl-k">PRIMARY KEY</span>,
    name <span class="pl-k">VARCHAR</span>(<span class="pl-c1">10</span>) <span class="pl-k">NOT NULL</span>,
    email <span class="pl-k">VARCHAR</span>(<span class="pl-c1">20</span>) <span class="pl-k">NOT NULL</span> <span class="pl-k">UNIQUE</span>,
    birth_date <span class="pl-k">DATETIME</span> <span class="pl-k">NOT NULL</span>, 
    phone_number <span class="pl-k">VARCHAR</span>(<span class="pl-c1">13</span>) <span class="pl-k">UNIQUE</span>,
    created_at <span class="pl-k">DATETIME</span> <span class="pl-k">NOT NULL</span> <span class="pl-k">DEFAULT</span> <span class="pl-c1">CURRENT_TIMESTAMP</span>,
    home_number <span class="pl-k">VARCHAR</span>(<span class="pl-c1">20</span>) <span class="pl-k">UNIQUE</span>,
    address <span class="pl-k">VARCHAR</span>(<span class="pl-c1">50</span>) <span class="pl-k">NOT NULL</span>,
    role <span class="pl-k">ENUM</span>(<span class="pl-s">'일반 사용자'</span>, <span class="pl-s">'생산자'</span>) <span class="pl-k">NOT NULL</span>,
    password_hash <span class="pl-k">VARCHAR</span>(<span class="pl-c1">100</span>) <span class="pl-k">NOT NULL</span>
)</pre>
</div>
</details>
<details><summary>📒 게시판 테이블</summary><div dir="auto">
  <div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="CREATE TABLE boards (
    board_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    users_id BIGINT NOT NULL,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    del_yn VARCHAR(1) DEFAULT 'N',
    title VARCHAR(255),
    contents VARCHAR(3000) NOT NULL,
    FOREIGN KEY (users_id) REFERENCES users(id)
);">
<pre><span class="pl-k">CREATE</span> <span class="pl-k">TABLE</span> <span class="pl-en">boards</span> (
    board_id <span class="pl-k">BIGINT</span> <span class="pl-k">AUTO_INCREMENT</span> <span class="pl-k">PRIMARY KEY</span>,
    users_id <span class="pl-k">BIGINT</span> <span class="pl-k">NOT NULL</span>,
    updated_at <span class="pl-k">TIMESTAMP</span> <span class="pl-k">NULL</span> <span class="pl-k">DEFAULT</span> <span class="pl-c1">NULL</span>,
    created_at <span class="pl-k">TIMESTAMP</span> <span class="pl-k">NOT NULL</span> <span class="pl-k">DEFAULT</span> <span class="pl-c1">CURRENT_TIMESTAMP</span>,
    del_yn <span class="pl-k">VARCHAR</span>(<span class="pl-c1">1</span>) <span class="pl-k">DEFAULT</span> <span class="pl-s">'N'</span>,
    title <span class="pl-k">VARCHAR</span>(<span class="pl-c1">255</span>),
    contents <span class="pl-k">VARCHAR</span>(<span class="pl-c1">3000</span>) <span class="pl-k">NOT NULL</span>,
    <span class="pl-k">FOREIGN KEY</span> (users_id) <span class="pl-k">REFERENCES</span> users(id)
)</pre>
</div>
</div>
</details>
<details><summary>✍️ 댓글 테이블</summary><div dir="auto">
  <div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="CREATE TABLE comments (
    idx BIGINT AUTO_INCREMENT PRIMARY KEY,
    board_id BIGINT NOT NULL,
    comment VARCHAR(1000) NOT NULL,
    comment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    del_yn VARCHAR(1) DEFAULT 'N',
    FOREIGN KEY (board_id) REFERENCES boards(board_id)
);">
<pre><span class="pl-k">CREATE</span> <span class="pl-k">TABLE</span> <span class="pl-en">comments</span> (
    idx <span class="pl-k">BIGINT</span> <span class="pl-k">AUTO_INCREMENT</span> <span class="pl-k">PRIMARY KEY</span>,
    board_id <span class="pl-k">BIGINT</span> <span class="pl-k">NOT NULL</span>,
    comment <span class="pl-k">VARCHAR</span>(<span class="pl-c1">1000</span>) <span class="pl-k">NOT NULL</span>,
    comment_date <span class="pl-k">TIMESTAMP</span> <span class="pl-k">NOT NULL</span> <span class="pl-k">DEFAULT</span> <span class="pl-c1">CURRENT_TIMESTAMP</span>,
    del_yn <span class="pl-k">VARCHAR</span>(<span class="pl-c1">1</span>) <span class="pl-k">DEFAULT</span> <span class="pl-s">'N'</span>,
    <span class="pl-k">FOREIGN KEY</span> (board_id) <span class="pl-k">REFERENCES</span> boards(board_id)
)</pre>
</div>
</div>
</details>
<details><summary>🔔 알림 테이블</summary><div dir="auto">
  <div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="CREATE TABLE notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    status ENUM('sent', 'failed', 'read') NOT NULL,
    title VARCHAR(50),
    content VARCHAR(255),
    created_at DATE,
    FOREIGN KEY (user_id) REFERENCES users(id)
);">
<pre><span class="pl-k">CREATE</span> <span class="pl-k">TABLE</span> <span class="pl-en">notifications</span> (
    id <span class="pl-k">INT</span> <span class="pl-k">AUTO_INCREMENT</span> <span class="pl-k">PRIMARY KEY</span>,
    user_id <span class="pl-k">BIGINT</span> <span class="pl-k">NOT NULL</span>,
    status <span class="pl-k">ENUM</span>(<span class="pl-s">'sent'</span>, <span class="pl-s">'failed'</span>, <span class="pl-s">'read'</span>) <span class="pl-k">NOT NULL</span>,
    title <span class="pl-k">VARCHAR</span>(<span class="pl-c1">50</span>),
    content <span class="pl-k">VARCHAR</span>(<span class="pl-c1">255</span>),
    created_at <span class="pl-k">DATE</span>,
    <span class="pl-k">FOREIGN KEY</span> (user_id) <span class="pl-k">REFERENCES</span> users(id)
)</pre>
</div>
</div>
</details>
<details><summary>🍅 작물 테이블</summary><div dir="auto">
  <div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="CREATE TABLE Crops (
    id INT NOT NULL,
    farm_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    item_name VARCHAR(50),
    start_date DATE,
    area DATE,
    status ENUM('growing', 'finished', 'discarded'),
    PRIMARY KEY (id, farm_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (farm_id) REFERENCES Farm(farm_id)
);">
<pre><span class="pl-k">CREATE</span> <span class="pl-k">TABLE</span> <span class="pl-en">Crops</span> (
    id <span class="pl-k">INT</span> <span class="pl-k">NOT NULL</span>,
    farm_id <span class="pl-k">BIGINT</span> <span class="pl-k">NOT NULL</span>,
    user_id <span class="pl-k">BIGINT</span> <span class="pl-k">NOT NULL</span>,
    item_name <span class="pl-k">VARCHAR</span>(<span class="pl-c1">50</span>),
    start_date <span class="pl-k">DATE</span>,
    area <span class="pl-k">DATE</span>,
    status <span class="pl-k">ENUM</span>(<span class="pl-s">'growing'</span>, <span class="pl-s">'finished'</span>, <span class="pl-s">'discarded'</span>),
    <span class="pl-k">PRIMARY KEY</span> (id, farm_id),
    <span class="pl-k">FOREIGN KEY</span> (user_id) <span class="pl-k">REFERENCES</span> users(id),
    <span class="pl-k">FOREIGN KEY</span> (farm_id) <span class="pl-k">REFERENCES</span> Farm(farm_id)
)</pre>
</div>
</details>
<details><summary>🌿 작물 상태 테이블</summary><div dir="auto">
  <div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="CREATE TABLE crops_state (
    id INT AUTO_INCREMENT,
    crops_id INT NOT NULL,
    crops_state ENUM('growing', 'finished', 'discarded'),
    growth_size FLOAT,
    health_state VARCHAR(50),
    sow_start_date DATE,
    price FLOAT,
    PRIMARY KEY (id),
    FOREIGN KEY (crops_id) REFERENCES crops(id)
);">
<pre><span class="pl-k">CREATE</span> <span class="pl-k">TABLE</span> <span class="pl-en">crops_state</span> (
    id <span class="pl-k">INT</span> <span class="pl-k">AUTO_INCREMENT</span>,
    crops_id <span class="pl-k">INT</span> <span class="pl-k">NOT NULL</span>,
    crops_state <span class="pl-k">ENUM</span>(<span class="pl-s">'growing'</span>, <span class="pl-s">'finished'</span>, <span class="pl-s">'discarded'</span>),
    growth_size <span class="pl-k">FLOAT</span>,
    health_state <span class="pl-k">VARCHAR</span>(<span class="pl-c1">50</span>),
    sow_start_date <span class="pl-k">DATE</span>,
    price <span class="pl-k">FLOAT</span>,
    <span class="pl-k">PRIMARY KEY</span> (id),
    <span class="pl-k">FOREIGN KEY</span> (crops_id) <span class="pl-k">REFERENCES</span> crops(id)
)</pre>
</div>
</div>
</details>
<details><summary>👨‍🌾 농장 테이블</summary><div dir="auto">
  <div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="CREATE TABLE Farm (
    farm_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);">
<pre><span class="pl-k">CREATE</span> <span class="pl-k">TABLE</span> <span class="pl-en">Farm</span> (
    farm_id <span class="pl-k">BIGINT</span> <span class="pl-k">AUTO_INCREMENT</span> <span class="pl-k">PRIMARY KEY</span>,
    user_id <span class="pl-k">BIGINT</span> <span class="pl-k">NOT NULL</span>,
    <span class="pl-k">FOREIGN KEY</span> (user_id) <span class="pl-k">REFERENCES</span> users(id)
)</pre>
</div>
</div>
</details>
<details><summary>💸 주문 테이블</summary><div dir="auto">
  <div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="CREATE TABLE Orders (
    order_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    crop_id BIGINT NOT NULL,
    quantity INT NOT NULL,
    price INT NOT NULL,
    status VARCHAR(50),
    request VARCHAR(50),
    date DATE,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (crop_id) REFERENCES crops(id)
);">
<pre><span class="pl-k">CREATE</span> <span class="pl-k">TABLE</span> <span class="pl-en">Orders</span> (
    order_id <span class="pl-k">BIGINT</span> <span class="pl-k">AUTO_INCREMENT</span> <span class="pl-k">PRIMARY KEY</span>,
    user_id <span class="pl-k">BIGINT</span> <span class="pl-k">NOT NULL</span>,
    crop_id <span class="pl-k">BIGINT</span> <span class="pl-k">NOT NULL</span>,
    quantity <span class="pl-k">INT</span> <span class="pl-k">NOT NULL</span>,
    price <span class="pl-k">INT</span> <span class="pl-k">NOT NULL</span>,
    status <span class="pl-k">VARCHAR</span>(<span class="pl-c1">50</span>),
    request <span class="pl-k">VARCHAR</span>(<span class="pl-c1">50</span>),
    date <span class="pl-k">DATE</span>,
    <span class="pl-k">FOREIGN KEY</span> (user_id) <span class="pl-k">REFERENCES</span> users(id),
    <span class="pl-k">FOREIGN KEY</span> (crop_id) <span class="pl-k">REFERENCES</span> crops(id)
)</pre>
</div>
</div>
</details>
<details><summary>🏭 재고 테이블</summary><div dir="auto">
  <div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="CREATE TABLE Inventory (
    idx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    crops_id BIGINT NOT NULL,
    farm_id BIGINT NOT NULL,
    expected_harvest_date DATE,
    expected_quantity INT,
    FOREIGN KEY (crops_id) REFERENCES Crops(id),
    FOREIGN KEY (farm_id) REFERENCES Farm(farm_id)
);">
<pre><span class="pl-k">CREATE</span> <span class="pl-k">TABLE</span> <span class="pl-en">Inventory</span> (
    idx <span class="pl-k">INT</span> <span class="pl-k">NOT NULL</span> <span class="pl-k">AUTO_INCREMENT</span> <span class="pl-k">PRIMARY KEY</span>,
    crops_id <span class="pl-k">BIGINT</span> <span class="pl-k">NOT NULL</span>,
    farm_id <span class="pl-k">BIGINT</span> <span class="pl-k">NOT NULL</span>,
    expected_harvest_date <span class="pl-k">DATE</span>,
    expected_quantity <span class="pl-k">INT</span>,
    <span class="pl-k">FOREIGN KEY</span> (crops_id) <span class="pl-k">REFERENCES</span> Crops(id),
    <span class="pl-k">FOREIGN KEY</span> (farm_id) <span class="pl-k">REFERENCES</span> Farm(farm_id)
)</pre>
</div>
</div>
</details>
<details><summary>🗳️ 배송 테이블</summary><div dir="auto">
  <div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="CREATE TABLE Delivery (
    id_delivery BIGINT AUTO_INCREMENT PRIMARY KEY,
    delivery_id BIGINT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    de_yn VARCHAR(1) DEFAULT 'N',
    courier VARCHAR(255),
    billing_number VARCHAR(255),
    delivery_at TIMESTAMP,
    delivery_status ENUM('ready', 'shipping', 'delivered', 'cancelled'),
    FOREIGN KEY (delivery_id) REFERENCES Orders(order_id)
);">
<pre><span class="pl-k">CREATE</span> <span class="pl-k">TABLE</span> <span class="pl-en">Delivery</span> (
    id_delivery <span class="pl-k">BIGINT</span> <span class="pl-k">AUTO_INCREMENT</span> <span class="pl-k">PRIMARY KEY</span>,
    delivery_id <span class="pl-k">BIGINT</span> <span class="pl-k">NOT NULL</span>,
    created_at <span class="pl-k">TIMESTAMP</span> <span class="pl-k">NOT NULL</span> <span class="pl-k">DEFAULT</span> <span class="pl-c1">CURRENT_TIMESTAMP</span>,
    updated_at <span class="pl-k">TIMESTAMP</span> <span class="pl-k">NULL</span> <span class="pl-k">DEFAULT</span> <span class="pl-c1">NULL</span> <span class="pl-k">ON UPDATE</span> <span class="pl-c1">CURRENT_TIMESTAMP</span>,
    de_yn <span class="pl-k">VARCHAR</span>(<span class="pl-c1">1</span>) <span class="pl-k">DEFAULT</span> <span class="pl-s">'N'</span>,
    courier <span class="pl-k">VARCHAR</span>(<span class="pl-c1">255</span>),
    billing_number <span class="pl-k">VARCHAR</span>(<span class="pl-c1">255</span>),
    delivery_at <span class="pl-k">TIMESTAMP</span>,
    delivery_status <span class="pl-k">ENUM</span>(<span class="pl-s">'ready'</span>, <span class="pl-s">'shipping'</span>, <span class="pl-s">'delivered'</span>, <span class="pl-s">'cancelled'</span>),
    <span class="pl-k">FOREIGN KEY</span> (delivery_id) <span class="pl-k">REFERENCES</span> Orders(order_id)
)</pre>
</div>
</div>
</details>
<details><summary>🏔️ 지역 테이블</summary><div dir="auto">
  <div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="CREATE TABLE Region (
    region_id VARCHAR(10) PRIMARY KEY,
    farm_id BIGINT NOT NULL,
    latitude DECIMAL(8,6) NOT NULL,
    longitude DECIMAL(9,6) NOT NULL,
    FOREIGN KEY (farm_id) REFERENCES Farm(farm_id)
);">
<pre><span class="pl-k">CREATE</span> <span class="pl-k">TABLE</span> <span class="pl-en">Region</span> (
    region_id <span class="pl-k">VARCHAR</span>(<span class="pl-c1">10</span>) <span class="pl-k">PRIMARY KEY</span>,
    farm_id <span class="pl-k">BIGINT</span> <span class="pl-k">NOT NULL</span>,
    latitude <span class="pl-k">DECIMAL</span>(<span class="pl-c1">8</span>,<span class="pl-c1">6</span>) <span class="pl-k">NOT NULL</span>,
    longitude <span class="pl-k">DECIMAL</span>(<span class="pl-c1">9</span>,<span class="pl-c1">6</span>) <span class="pl-k">NOT NULL</span>,
    <span class="pl-k">FOREIGN KEY</span> (farm_id) <span class="pl-k">REFERENCES</span> Farm(farm_id)
)</pre>
</div>
</div>
</details>
<details><summary>🌞 날씨 데이터 테이블</summary><div dir="auto">
  <div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="CREATE TABLE Weather (
    observation_time DATETIME NOT NULL,
    region_id VARCHAR(10) NOT NULL,
    temp_avg FLOAT,
    humidity FLOAT,
    solar_radiation FLOAT,
    PRIMARY KEY (observation_time, region_id),
    FOREIGN KEY (region_id) REFERENCES Region(region_id)
);">
<pre><span class="pl-k">CREATE</span> <span class="pl-k">TABLE</span> <span class="pl-en">Weather</span> (
    observation_time <span class="pl-k">DATETIME</span> <span class="pl-k">NOT NULL</span>,
    region_id <span class="pl-k">VARCHAR</span>(<span class="pl-c1">10</span>) <span class="pl-k">NOT NULL</span>,
    temp_avg <span class="pl-k">FLOAT</span>,
    humidity <span class="pl-k">FLOAT</span>,
    solar_radiation <span class="pl-k">FLOAT</span>,
    <span class="pl-k">PRIMARY KEY</span> (observation_time, region_id),
    <span class="pl-k">FOREIGN KEY</span> (region_id) <span class="pl-k">REFERENCES</span> Region(region_id)
)</pre>
</div>
</div>
</details>
<details><summary>🔭 예측 테이블</summary><div dir="auto">
  <div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="CREATE TABLE Predictions (
    idx BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    crops_id BIGINT NOT NULL,
    farm_id BIGINT,
    predicted_harvest_date DATE,
    predicted_quantity INT,
    created_at DATE,
    FOREIGN KEY (crops_id) REFERENCES Crops(id),
    FOREIGN KEY (farm_id) REFERENCES Farm(farm_id)
);">
<pre><span class="pl-k">CREATE</span> <span class="pl-k">TABLE</span> <span class="pl-en">Predictions</span> (
    idx <span class="pl-k">BIGINT</span> <span class="pl-k">NOT NULL</span> <span class="pl-k">AUTO_INCREMENT</span> <span class="pl-k">PRIMARY KEY</span>,
    crops_id <span class="pl-k">BIGINT</span> <span class="pl-k">NOT NULL</span>,
    farm_id <span class="pl-k">BIGINT</span>,
    predicted_harvest_date <span class="pl-k">DATE</span>,
    predicted_quantity <span class="pl-k">INT</span>,
    created_at <span class="pl-k">DATE</span>,
    <span class="pl-k">FOREIGN KEY</span> (crops_id) <span class="pl-k">REFERENCES</span> Crops(id),
    <span class="pl-k">FOREIGN KEY</span> (farm_id) <span class="pl-k">REFERENCES</span> Farm(farm_id)
)</pre>
</div>
</div>
</details>
<br>
<h2>📌 SQL 테스트</h2>
<div align="center">
  <a href="https://www.notion.so/SQL-21785def4f6d80e2a9e0dc591210f5d7" target="_blank">🔗 SQL 테스트 노션 페이지 바로가기</a>
</div>



