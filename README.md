# Sabail – Islamic Companion App

**Sabail** is a Flutter-based mobile application offering a suite of useful tools for Muslims around the world:

- **Home Dashboard**: Quick access to key features  
- **Prayer Times**: Accurate local prayer schedules  
- **Qur’an**: Browse Surahs and Ayahs with translations  
- **Profile**: Manage account, settings and donations  

Built with MVVM architecture, Drift (SQLite) for local storage, and a modern floating bottom navigation bar.

---

## 🔧 Features

- **Prayer Times**: Fetch & cache daily times, set notifications  
- **Qur’an Reading**: Local DB of Surahs/Ayahs, text & translation  
- **Hadith Library**: (planned) Browse major collections  
- **Tasbih Counter**: Customisable tasbih sessions & history  
- **Qibla Compass**: Real-time direction based on GPS  
- **Donations**: Track charity payments & history  
- **Settings & Profile**: Theme, language, account info  

---

## 🏗 Architecture Overview

- **Presentation**  
  - Screens & Widgets (`lib/src/features/.../presentation/views`)  
  - ViewModels (`lib/src/features/.../presentation/viewmodels`)  

- **Domain**  
  - Entities & UseCases (`lib/src/features/.../domain`)  

- **Data**  
  - Repositories & DataSources (`lib/src/features/.../data`)  
  - Local: Drift (SQLite)  
  - Remote: REST APIs  

- **Core**  
  - DI setup (`lib/src/core/di`)  
  - Routing & navigation (`lib/app.dart`)  
  - Shared widgets, themes, constants  

---

## 📁 Directory Structure

