ctx, cancel := context.WithCancel(context.Background())
go func() {
    c := make(chan os.Signal, 1)
    signal.Notify(c, syscall.SIGINT, syscall.SIGTERM)
    defer signal.Stop(c)

    select {
    case <-ctx.Done():
    case <-c:
        cancel()
    }
}()

