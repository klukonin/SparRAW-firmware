/* lmac_if__awake_peers_evt @ 0x8d8078, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   AWAKE PEERS EVENT: awake peers vector = 0x%x , awake no tx peers vector = 0x%x, notification_type: %x
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, awake_peers__log, fw_log__emit3, ps__on_awake_peers, ps__store_awake_count
 */
	.section .text.lmac_if__awake_peers_evt,"ax",@progbits
	.global lmac_if__awake_peers_evt
lmac_if__awake_peers_evt:
	.global L_8d8078
L_8d8078:
	push_s blink
L_8d807a:
	bl L_8c02c4
L_8d807e:
	mov_s r13,r0
L_8d8080:
	mov_s r14,r1
L_8d8082:
	ldb r4,[r0, 0x2]
L_8d8086:
	mov_s r2,0x1004488
L_8d808c:
	ldb r5,[r0, 0x3]
L_8d8090:
	mov_s r0,0xe
L_8d8092:
	mov_s r1,0x2
L_8d8094:
	bl.d L_8ee034
L_8d8098:
	ldb_s r3,[r13,0x1]
L_8d809a:
	bl L_8dcdd8
L_8d809e:
	bl.d L_8c3604
L_8d80a2:
	mov_s r0,r13
L_8d80a4:
	ldb_s r0,[r13,0x3]
L_8d80a6:
	cmp_s r0,0x2
L_8d80a8:
	bl.eq.d L_8edc1c
L_8d80ac:
	mov.eq r0,r14
L_8d80b0:
	b L_8c0334
