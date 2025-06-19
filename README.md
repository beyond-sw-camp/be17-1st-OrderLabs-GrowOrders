![제목 없는 다이어그램 drawio (5)](https://github.com/user-attachments/assets/4b609c7a-039d-4e9f-8b08-7119738366bc)
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

## 📝 요구 사항 명세서
![요구사항2](./02_요구사항%20정의서.png)

<br><br>

## ☁️ ERD
![OrderLabs-erd](./03_ERD.png)
<div align=center>
  
  [⬆️ERD CLOUD 바로가기](https://www.erdcloud.com/d/GjgSeJRtpNC9jNFpG)
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

<div class="markdown-heading" dir="auto"><h2 tabindex="-1" class="heading-element" dir="auto">📌 구축 쿼리 (DDL)</h2><a id="user-content--구축-쿼리-ddl" class="anchor" aria-label="Permalink: 📌 구축 쿼리 (DDL)" href="#-구축-쿼리-ddl"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path d="m7.775 3.275 1.25-1.25a3.5 3.5 0 1 1 4.95 4.95l-2.5 2.5a3.5 3.5 0 0 1-4.95 0 .751.751 0 0 1 .018-1.042.751.751 0 0 1 1.042-.018 1.998 1.998 0 0 0 2.83 0l2.5-2.5a2.002 2.002 0 0 0-2.83-2.83l-1.25 1.25a.751.751 0 0 1-1.042-.018.751.751 0 0 1-.018-1.042Zm-4.69 9.64a1.998 1.998 0 0 0 2.83 0l1.25-1.25a.751.751 0 0 1 1.042.018.751.751 0 0 1 .018 1.042l-1.25 1.25a3.5 3.5 0 1 1-4.95-4.95l2.5-2.5a3.5 3.5 0 0 1 4.95 0 .751.751 0 0 1-.018 1.042.751.751 0 0 1-1.042.018 1.998 1.998 0 0 0-2.83 0l-2.5 2.5a1.998 1.998 0 0 0 0 2.83Z"></path></svg></a></div>
<details>
<summary>🙆 회원 테이블</summary>
<div dir="auto">
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" data-snippet-clipboard-copy-content="CREATE TABLE users (
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
);" dir="auto"><pre><span class="pl-k">create</span> <span class="pl-k">table</span> <span class="pl-en">member</span> (
    id			<span class="pl-k">bigint</span> <span class="pl-k">primary key</span> auto_increment,
    email			<span class="pl-k">varchar</span>(<span class="pl-c1">255</span>) <span class="pl-k">not null</span> unique,
    name			<span class="pl-k">varchar</span>(<span class="pl-c1">255</span>) <span class="pl-k">not null</span>,
    password		<span class="pl-k">varchar</span>(<span class="pl-c1">255</span>) <span class="pl-k">not null</span>,
    account_date	datetime <span class="pl-k">not null</span> default <span class="pl-c1">CURRENT_TIMESTAMP</span>,
    member_type		enum(<span class="pl-s"><span class="pl-pds">'</span>user<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>company<span class="pl-pds">'</span></span>) default <span class="pl-s"><span class="pl-pds">'</span>user<span class="pl-pds">'</span></span>,
    state			enum(<span class="pl-s"><span class="pl-pds">'</span>online<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>offline<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>withdraw<span class="pl-pds">'</span></span>) default <span class="pl-s"><span class="pl-pds">'</span>offline<span class="pl-pds">'</span></span>
)</pre></div>
</div>

<details><summary>🏢 회사 테이블</summary></details>
<details><summary>📋 이력서 테이블</summary></details>
<details><summary>📣 채용 공고 테이블</summary></details>
<details><summary>⏲ 지원 내역 테이블</summary></details>
<details><summary>📎 스크랩 테이블</summary></details>
<details><summary>⭐ 기업 리뷰 테이블</summary></details>
<details><summary>🔖 태그 테이블</summary></details>
<details><summary>🔖 태그 리뷰 테이블</summary></details>
<div class="markdown-heading" dir="auto"><h2 class="heading-element" dir="auto" tabindex="-1">📌 프로시저 구현</h2><a aria-label="Permalink: 📌 프로시저 구현" class="anchor" href="#-프로시저-구현" id="user-content--프로시저-구현"><svg aria-hidden="true" class="octicon octicon-link" height="16" version="1.1" viewbox="0 0 16 16" width="16"><path d="m7.775 3.275 1.25-1.25a3.5 3.5 0 1 1 4.95 4.95l-2.5 2.5a3.5 3.5 0 0 1-4.95 0 .751.751 0 0 1 .018-1.042.751.751 0 0 1 1.042-.018 1.998 1.998 0 0 0 2.83 0l2.5-2.5a2.002 2.002 0 0 0-2.83-2.83l-1.25 1.25a.751.751 0 0 1-1.042-.018.751.751 0 0 1-.018-1.042Zm-4.69 9.64a1.998 1.998 0 0 0 2.83 0l1.25-1.25a.751.751 0 0 1 1.042.018.751.751 0 0 1 .018 1.042l-1.25 1.25a3.5 3.5 0 1 1-4.95-4.95l2.5-2.5a3.5 3.5 0 0 1 4.95 0 .751.751 0 0 1-.018 1.042.751.751 0 0 1-1.042.018 1.998 1.998 0 0 0-2.83 0l-2.5 2.5a1.998 1.998 0 0 0 0 2.83Z"></path></svg></a></div>
<details><summary>🙆 회원 프로시저</summary></details>
<details><summary>🏢 회사 프로시저</summary></details>
<details><summary>📋 이력서 프로시저</summary></details>
<details><summary>📣 채용 공고 프로시저</summary></details>
<details><summary>⏲ 지원 내역 프로시저</summary></details>
<details><summary>📎 스크랩 프로시저</summary></details>
<details><summary>⭐ 기업 리뷰 프로시저</summary></details>
