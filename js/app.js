    /** @jsx React.DOM */
    var APP = React.createClass({
      render: function() {
        return (
          <div>
            <h1>THIS</h1>
          </div>
        )
      }
    });

    React.renderComponent(<APP />, document.getElementById('test'))