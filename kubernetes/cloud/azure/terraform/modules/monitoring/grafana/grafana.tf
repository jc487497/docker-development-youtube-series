resource "kubernetes_manifest" "secret_grafana_datasources" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "datasources.yaml" = "ewogICAgImFwaVZlcnNpb24iOiAxLAogICAgImRhdGFzb3VyY2VzIjogWwogICAgICAgIHsKICAgICAgICAgICAgImFjY2VzcyI6ICJwcm94eSIsCiAgICAgICAgICAgICJlZGl0YWJsZSI6IGZhbHNlLAogICAgICAgICAgICAibmFtZSI6ICJwcm9tZXRoZXVzIiwKICAgICAgICAgICAgIm9yZ0lkIjogMSwKICAgICAgICAgICAgInR5cGUiOiAicHJvbWV0aGV1cyIsCiAgICAgICAgICAgICJ1cmwiOiAiaHR0cDovL3Byb21ldGhldXMtazhzLm1vbml0b3Jpbmcuc3ZjOjkwOTAiLAogICAgICAgICAgICAidmVyc2lvbiI6IDEKICAgICAgICB9CiAgICBdCn0="
    }
    "kind" = "Secret"
    "metadata" = {
      "name" = "grafana-datasources"
      "namespace" = "monitoring"
    }
    "type" = "Opaque"
  }
}
resource "kubernetes_manifest" "configmap_grafana_dashboard_nodeexporter" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
    
    }
    "kind" = "ConfigMap"
    "metadata" = {
      "name" = "grafana-dashboard-nodeexporter"
      "namespace" = "monitoring"
    }
  }
}
resource "kubernetes_manifest" "configmap_grafana_dashboards" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "dashboards.yaml" = "{\n    \"apiVersion\": 1,\n    \"providers\": [\n        {\n            \"folder\": \"Default\",\n            \"name\": \"0\",\n            \"options\": {\n                \"path\": \"/grafana-dashboard-definitions/0\"\n            },\n            \"orgId\": 1,\n            \"type\": \"file\"\n        }\n    ]\n}"
    }
    "kind" = "ConfigMap"
    "metadata" = {
      "name" = "grafana-dashboards"
      "namespace" = "monitoring"
    }
  }
}
resource "kubernetes_manifest" "deployment_grafana" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app" = "grafana"
      }
      "name" = "grafana"
      "namespace" = "monitoring"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "grafana"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "grafana"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = []
              "image" = "grafana/grafana:6.7.4"
              "name" = "grafana"
              "ports" = [
                {
                  "containerPort" = 3000
                  "name" = "http"
                },
              ]
              "readinessProbe" = {
                "httpGet" = {
                  "path" = "/api/health"
                  "port" = "http"
                }
              }
              "resources" = {
                "limits" = {
                  "cpu" = "200m"
                  "memory" = "200Mi"
                }
                "requests" = {
                  "cpu" = "100m"
                  "memory" = "100Mi"
                }
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/var/lib/grafana"
                  "name" = "grafana-storage"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/etc/grafana/provisioning/datasources"
                  "name" = "grafana-datasources"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/etc/grafana/provisioning/dashboards"
                  "name" = "grafana-dashboards"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/nodeexporter"
                  "name" = "grafana-dashboard-nodeexporter"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/apiserver"
                  "name" = "grafana-dashboard-apiserver"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/cluster-total"
                  "name" = "grafana-dashboard-cluster-total"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/controller-manager"
                  "name" = "grafana-dashboard-controller-manager"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/k8s-resources-cluster"
                  "name" = "grafana-dashboard-k8s-resources-cluster"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/k8s-resources-namespace"
                  "name" = "grafana-dashboard-k8s-resources-namespace"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/k8s-resources-node"
                  "name" = "grafana-dashboard-k8s-resources-node"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/k8s-resources-pod"
                  "name" = "grafana-dashboard-k8s-resources-pod"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/k8s-resources-workload"
                  "name" = "grafana-dashboard-k8s-resources-workload"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/k8s-resources-workloads-namespace"
                  "name" = "grafana-dashboard-k8s-resources-workloads-namespace"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/kubelet"
                  "name" = "grafana-dashboard-kubelet"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/namespace-by-pod"
                  "name" = "grafana-dashboard-namespace-by-pod"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/namespace-by-workload"
                  "name" = "grafana-dashboard-namespace-by-workload"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/node-cluster-rsrc-use"
                  "name" = "grafana-dashboard-node-cluster-rsrc-use"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/node-rsrc-use"
                  "name" = "grafana-dashboard-node-rsrc-use"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/nodes"
                  "name" = "grafana-dashboard-nodes"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/persistentvolumesusage"
                  "name" = "grafana-dashboard-persistentvolumesusage"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/pod-total"
                  "name" = "grafana-dashboard-pod-total"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/prometheus-remote-write"
                  "name" = "grafana-dashboard-prometheus-remote-write"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/prometheus"
                  "name" = "grafana-dashboard-prometheus"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/proxy"
                  "name" = "grafana-dashboard-proxy"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/scheduler"
                  "name" = "grafana-dashboard-scheduler"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/statefulset"
                  "name" = "grafana-dashboard-statefulset"
                  "readOnly" = false
                },
                {
                  "mountPath" = "/grafana-dashboard-definitions/0/workload-total"
                  "name" = "grafana-dashboard-workload-total"
                  "readOnly" = false
                },
              ]
            },
          ]
          "nodeSelector" = {
            "beta.kubernetes.io/os" = "linux"
          }
          "securityContext" = {
            "runAsNonRoot" = true
            "runAsUser" = 65534
          }
          "serviceAccountName" = "grafana"
          "volumes" = [
            {
              "emptyDir" = {}
              "name" = "grafana-storage"
            },
            {
              "name" = "grafana-datasources"
              "secret" = {
                "secretName" = "grafana-datasources"
              }
            },
            {
              "configMap" = {
                "name" = "grafana-dashboards"
              }
              "name" = "grafana-dashboards"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-nodeexporter"
              }
              "name" = "grafana-dashboard-nodeexporter"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-apiserver"
              }
              "name" = "grafana-dashboard-apiserver"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-cluster-total"
              }
              "name" = "grafana-dashboard-cluster-total"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-controller-manager"
              }
              "name" = "grafana-dashboard-controller-manager"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-k8s-resources-cluster"
              }
              "name" = "grafana-dashboard-k8s-resources-cluster"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-k8s-resources-namespace"
              }
              "name" = "grafana-dashboard-k8s-resources-namespace"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-k8s-resources-node"
              }
              "name" = "grafana-dashboard-k8s-resources-node"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-k8s-resources-pod"
              }
              "name" = "grafana-dashboard-k8s-resources-pod"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-k8s-resources-workload"
              }
              "name" = "grafana-dashboard-k8s-resources-workload"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-k8s-resources-workloads-namespace"
              }
              "name" = "grafana-dashboard-k8s-resources-workloads-namespace"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-kubelet"
              }
              "name" = "grafana-dashboard-kubelet"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-namespace-by-pod"
              }
              "name" = "grafana-dashboard-namespace-by-pod"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-namespace-by-workload"
              }
              "name" = "grafana-dashboard-namespace-by-workload"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-node-cluster-rsrc-use"
              }
              "name" = "grafana-dashboard-node-cluster-rsrc-use"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-node-rsrc-use"
              }
              "name" = "grafana-dashboard-node-rsrc-use"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-nodes"
              }
              "name" = "grafana-dashboard-nodes"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-persistentvolumesusage"
              }
              "name" = "grafana-dashboard-persistentvolumesusage"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-pod-total"
              }
              "name" = "grafana-dashboard-pod-total"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-prometheus-remote-write"
              }
              "name" = "grafana-dashboard-prometheus-remote-write"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-prometheus"
              }
              "name" = "grafana-dashboard-prometheus"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-proxy"
              }
              "name" = "grafana-dashboard-proxy"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-scheduler"
              }
              "name" = "grafana-dashboard-scheduler"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-statefulset"
              }
              "name" = "grafana-dashboard-statefulset"
            },
            {
              "configMap" = {
                "name" = "grafana-dashboard-workload-total"
              }
              "name" = "grafana-dashboard-workload-total"
            },
          ]
        }
      }
    }
  }
}
resource "kubernetes_manifest" "serviceaccount_grafana" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "ServiceAccount"
    "metadata" = {
      "name" = "grafana"
      "namespace" = "monitoring"
    }
  }
}
resource "kubernetes_manifest" "service_grafana" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app" = "grafana"
      }
      "name" = "grafana"
      "namespace" = "monitoring"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "http"
          "port" = 3000
          "targetPort" = "http"
        },
      ]
      "selector" = {
        "app" = "grafana"
      }
    }
  }
}
