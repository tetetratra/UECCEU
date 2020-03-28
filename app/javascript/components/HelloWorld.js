import React from "react"
import PropTypes from "prop-types"

class HelloWorld extends React.Component {
  constructor (props) {
    super(props)
    this.table = this.props.courses.map(
      c => {
        <p>
          aieuo
        </p>
        // c.course_title_japanese
        // String(Object.keys(c))
      }
    )
    //
  }
  render () {
    return (
      <p>
        テーブル: {this.table}
      </p>
    );
  }
}

// HelloWorld.propTypes = {
//   greeting: PropTypes.string
// };
export default HelloWorld
