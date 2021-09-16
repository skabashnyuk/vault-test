package org.acme.quickstart;

import io.quarkus.vault.VaultKVSecretEngine;
import io.quarkus.vault.test.VaultTestLifecycleManager;

import javax.inject.Inject;
import java.io.IOException;
import java.util.Map;

public class SpiVaultTestLifecycleManager extends VaultTestLifecycleManager {
    @Inject
    static VaultKVSecretEngine kvSecretEngine;

    @Override
    public Map<String, String> start()  {

        Map<String, String> result = super.start();

        System.out.println("=========");
        System.out.println("=========");
        System.out.println("=========");
        System.out.println("=========");
        System.out.println("=========");
        try {
            vaultTestExtension.vaultContainer.execInContainer("vault kv put secret/myapps/vault-quickstart/config a-private-key=123456");
        } catch (InterruptedException | IOException e) {
            throw new RuntimeException(e);
        }
        System.out.println("=========");
        System.out.println("===done======");
        System.out.println("=========");
        return result;
    }
}
