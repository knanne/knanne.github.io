{% extends "knanne_template.tpl" %}

{% block header %}
  <script src="https://cdn.jsdelivr.net/npm/vega@3"></script>
  <script src="https://cdn.jsdelivr.net/npm/vega-lite@2"></script>
  <script src="https://cdn.jsdelivr.net/npm/vega-embed@3"></script>
  {{super()}}
{% endblock header %}

{% block data_priority scoped %}
{% for mimetype in ('application/vnd.vegalite.v1+json','application/vnd.vega.v2+json','application/vnd.vegalite.v2+json','application/vnd.vega.v3+json') %}
    {% if mimetype in output.data %}
        <div id="vis{{cell['execution_count']}}"></div>
        <script type="text/javascript">
            var spec = {{ output.data[mimetype] }};
            var opt = {"renderer": "canvas", "actions": false};
            vegaEmbed("#vis{{cell['execution_count']}}", spec, opt);
        </script>
    {% elif loop.index == 1 %}
        {{super()}}
    {% endif %}
{% endfor %}
{% endblock data_priority %}
