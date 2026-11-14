---
layout: page
permalink: /research.html
title: Research
nav: true
nav_order: 1
---

I study data mining and machine learning for structured data that evolve over time.

**Research vision**

## From complex observations to useful knowledge

Modern systems produce observations involving many entities, attributes, and time-varying relationships. My research follows three connected steps: represent this structure, learn how it changes as new data arrive, and use the resulting model for anomaly detection and prediction of future events.

## Research areas

### Tensor and dynamic network mining

The first challenge is representation. Tensors and temporal graphs provide natural representations of datasets involving entities, time, location, and context. I develop models that preserve these interacting dimensions while extracting components and network structures that can be interpreted.

### Data streams and time-series analysis

The second challenge is learning over time. Sensor readings, event logs, online activity, and epidemiological observations may change at several timescales. I study online methods that update efficiently as observations arrive, identify recurring temporal patterns, and track structural change without repeatedly processing the full history.

### Anomaly detection and prediction

The final challenge is inference. Using the learned temporal and structural patterns, I develop methods that distinguish meaningful anomalies from ordinary variation and predict future behavior. The goal is to provide scores and forecasts together with explanations of the entities, relationships, and temporal patterns that support them.

## Design principles

Across these three stages, I combine probabilistic modeling, matrix and tensor factorization, network analysis, and streaming algorithms. The methods are designed around three principles:

- **Scalability** to large, continuously arriving datasets
- **Adaptivity** to changing patterns and operating conditions
- **Interpretability** of the structures and anomalies identified by the model

## Evaluation and applications

I evaluate the methods on synthetic data with controlled properties and on real-world datasets from domains including:

- sensor and event streams
- social and interaction networks
- cybersecurity systems
- epidemiological time series
- heterogeneous communication graphs

## Selected work

### [Interpretable Dynamic Network Modeling of Tensor Time Series via Kronecker Time-Varying Graphical Lasso](https://doi.org/10.1145/3774904.3792608)

A structured graphical model that estimates how networks within tensor time series change over time. *The Web Conference 2026.*

### [Fast Mining and Dynamic Time-to-Event Prediction over Multi-sensor Data Streams](https://doi.org/10.1145/3770854.3780164)

An online method for modeling multi-sensor streams and updating time-to-event predictions as observations arrive. *KDD 2026.*

### [RoleMine: Mining Behavioral Patterns in Heterogeneous Call Graphs](https://doi.org/10.1145/3799682.3840789)

A role–topic model that represents attributed interaction graphs and identifies anomalous nodes with interpretable evidence. *CIKM 2026.*

[View all publications →]({{ '/publications.html' | relative_url }})
