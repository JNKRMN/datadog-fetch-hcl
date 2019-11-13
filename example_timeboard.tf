resource "datadog_timeboard" "platform-oos-dashboard" {
  title       = "Platform (OOS) Dashboard"
  description = "created by alexw@weedmaps.com (cloned)"
  read_only   = true

  template_variable {
    name    = "environment"
    default = "production"
    prefix  = "env"
  }

  template_variable {
    name    = "rancher_stack"
    default = "platform"
    prefix  = "rancher_stack"
  }

  graph {
    title = "NewRelic Throughput"
    viz   = "timeseries"

    request {
      q    = "sum:new_relic.application_summary.throughput{application:online_ordering_service_production}"
      type = "line"

      style {
        palette = "dog_classic"
        width   = "normal"
        type    = "solid"
      }
    }
  }

  graph {
    title = "NewRelic Response Time"
    viz   = "timeseries"

    request {
      q    = "avg:new_relic.application_summary.response_time{application:online_ordering_service_production}"
      type = "line"

      style {
        palette = "dog_classic"
        width   = "normal"
        type    = "solid"
      }
    }
  }

  graph {
    title = "System Memory in Use"
    viz   = "timeseries"

    request {
      q    = "avg:docker.mem.rss{$environment,$rancher_stack} by {rancher_container}"
      type = "line"

      style {
        palette = "dog_classic"
        width   = "normal"
        type    = "solid"
      }
    }
  }

  graph {
    title = "System CPU, User CPU"
    viz   = "timeseries"

    request {
      q    = "avg:docker.cpu.usage{$environment,$rancher_stack} by {rancher_container}"
      type = "line"

      style {
        palette = "dog_classic"
        width   = "normal"
        type    = "solid"
      }
    }
  }
}
