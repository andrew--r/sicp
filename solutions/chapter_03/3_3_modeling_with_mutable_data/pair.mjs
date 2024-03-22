export function pair(x, y) {
  function set_x(v) {
    x = v;
  }
  function set_y(v) {
    y = v;
  }
  return (m) =>
    m === "head"
      ? x
      : m === "tail"
      ? y
      : m === "set_head"
      ? set_x
      : m === "set_tail"
      ? set_y
      : error(m, "undefined operation -- pair");
}

export function head(z) {
  return z("head");
}

export function tail(z) {
  return z("tail");
}

export function set_head(z, new_value) {
  z("set_head")(new_value);
  return z;
}

export function set_tail(z, new_value) {
  z("set_tail")(new_value);
  return z;
}
