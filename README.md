<div align="center">
# DevOps Portfolio — Path Operaciones1
[![TP07 CI/CD](https://github.com/melaniedenisemai/devops-TP06/actions/workflows/cicd.yml/badge.svg)](https://github.com/melaniedenisemai/devops-TP06/actions)
[![Licencia MIT](https://img.shields.io/badge/licencia-MIT-green.svg)](LICENSE)
[![Hecho con](https://img.shields.io/badge/hecho%20con-WSL2%20%2B%20Ubuntu-blue.svg)](https://ubuntu.com)
</div>

---

## Sobre este portfolio
Aprendí DevOps desde cero en Operaciones1 aplicando herramientas y estándares de la industria.
Cada TP representa un hito práctico entregado en GitHub demostrando el flujo completo de CI/CD e infraestructura.

---

## Stack tecnológico
| Categoría | Herramientas |
|---|---|
| **OS / Scripting** | Linux (Ubuntu / WSL2), Bash |
| **Control de versiones** | Git, GitHub, Gitflow |
| **Contenedores** | Docker, Docker Compose |
| **CI/CD** | GitHub Actions |
| **Monitoreo** | Prometheus, Grafana, cAdvisor, Node Exporter |
| **Orquestación** | Kubernetes (kubectl, Helm) |
| **IaC** | Terraform (provider Docker / K8s) |
| **Backend / DB / Proxy** | Python (Flask), PostgreSQL, NGINX |
| **Config / Formatos** | YAML, HCL, JSON |

---

## Proyectos por TP
### 1 al 4 — Fundamentos
| TP | Proyecto | Tecnologías | Link |
|---|---|---|---|
| 1 | Script de automatización del sistema | Bash, cron | [→ ver repo](https://github.com/melaniedenisemai/devops-TP01) |
| 2 | Gestión de usuarios y permisos | Linux, chmod, useradd | [→ ver repo](https://github.com/melaniedenisemai/devops-TP02) |
| 3 | Flujo Gitflow completo | Git, GitHub, branching | [→ ver repo](https://github.com/melaniedenisemai/devops-TP03) |
| 4 | YAML multi-entorno + diagnóstico de red | YAML, bash, ping, dig, curl | [→ ver repo](https://github.com/melaniedenisemai/devops-TP04) |

### 5 al 8 — Contenedores y CI/CD
| TP | Proyecto | Tecnologías | Link |
|---|---|---|---|
| 5 | API Python en Docker | Docker, Flask, Gunicorn | [→ ver repo](https://github.com/melaniedenisemai/devops-TP05) |
| 6 | App multi-contenedor | Docker Compose, Postgres, Nginx | [→ ver repo](https://github.com/melaniedenisemai/devops-TP06) |
| 7 | Pipeline CI/CD completo | GitHub Actions, pytest, Docker Hub | [→ ver repo](https://github.com/melaniedenisemai/devops-TP06) |
| 8 | Stack de monitoreo | Prometheus, Grafana, Node Exporter | [→ ver repo](https://github.com/melaniedenisemai/devops-TP08) |

### 9 al 12 — Kubernetes e IaC
| TP | Proyecto | Tecnologías | Link |
|---|---|---|---|
| 9 | App en Kubernetes | kubectl, Pods, Deployments, Services | [→ ver repo](https://github.com/melaniedenisemai/devops-TP09) |
| 10 | Helm Chart + Ingress | Helm, Ingress NGINX, HPA | [→ ver repo](https://github.com/melaniedenisemai/devops-TP10) |
| 11 | Infraestructura como Código | Terraform, módulos, state | [→ ver repo](https://github.com/melaniedenisemai/devops-TP11) |
| 12 | Portfolio final | GitHub Actions, integración | [→ este repo](https://github.com/melaniedenisemai/devops-portfolio) |

---

## Proyecto integrador: Notes App
La aplicación construida a lo largo del trayecto evolucionó en un sistema completo end-to-end:
`Código → GitHub Actions (CI) → Docker Hub → Kubernetes (CD) → Prometheus + Grafana (Monitoreo)`

**Repo principal:** [devops-TP06](https://github.com/melaniedenisemai/devops-TP06)
# TP12B: Despliegue del stack de monitoreo (Prometheus, Grafana, Node Exporter y cAdvisor) en Kubernetes para NotesApp.

## TP12C — Alertas de Ciberseguridad y Detección de Anomalías

Se implementó una capa proactiva de detección de incidentes sobre el clúster de Kubernetes (`devops-portfolio`), instrumentando reglas de alerta en Prometheus y visualización de rutas de error (*sad paths*) en Grafana:

- **Reglas de Alerta (`prometheus-alerts-security.yml`):**
  - `IngressPicoErrores4xx5xx`: Detección de escaneos y ataques de fuerza bruta (picos de errores 4xx/5xx).
  - `InvasionIntentosAuthFallidos`: Detección de anomalías en el endpoint de autenticación `/login`.
  - `PodReiniciosFrecuentesSeguridad` & `PicoErroresConexionBaseDatos`: Monitoreo de estabilidad de Pods y capa de persistencia PostgreSQL.
- **Simulación y Validación (`scripts/generar-alertas-seguridad.sh`):**
  - Script automatizado para la generación de tráfico anómalo y verificación del ciclo de vida de alertas (`pending` -> `firing`).

