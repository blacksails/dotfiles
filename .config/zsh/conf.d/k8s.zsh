kgsk() {
  kubectl get secret ${@: 1:-1} \
    -ojsonpath="{.data['$(echo -n ${@: -1} | sed 's/\./\\\./g')']}" \
  | base64 -d
}
