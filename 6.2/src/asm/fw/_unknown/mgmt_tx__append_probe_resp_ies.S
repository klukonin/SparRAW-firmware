/* mgmt_tx__append_probe_resp_ies @ 0x8d8000, 244 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   MGMT TX Probe resp ssid IE length %d total %d
 *   MGMT TX Probe resp RSN IE length %d total %d
 *   MGMT TX Probe resp dband cap length %d total %d
 *   MGMT TX Probe resp vendor specific length %d total %d
 *   MGMT TX Probe resp dband oper length %d total %d
 *   MGMT TX Probe resp dband ANT length %d total %d
 * Зовут его: mgmt_tx__build_probe_resp
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit2, ie__push_dmg_capabilities, ie__push_edca, ie__push_eid151_len10, ie__push_eid190_len4, ie__push_qos_capability, ie__push_raw, ie__push_ssid, mgmt_tx__copy_ie_max96, mid__copy_ssid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mgmt_tx__append_probe_resp_ies
mgmt_tx__append_probe_resp_ies:
	.global L_8d8000
L_8d8000:
	push_s blink
L_8d8002:
	bl L_8c01e0
L_8d8006:
	sub_s sp,sp,0x20
L_8d8008:
	mov_s r15,r0
L_8d800a:
	mov_s r14,r1
L_8d800c:
	mov_s r13,sp
L_8d800e:
	mov_s r0,r1
L_8d8010:
	bl.d L_8ccc98
L_8d8014:
	mov_s r1,r13
L_8d8016:
	extb_s r2,r0
L_8d8018:
	mov_s r0,r15
L_8d801a:
	bl.d L_8e2028
L_8d801e:
	mov_s r1,r13
L_8d8020:
	mov_s r13,r0
L_8d8022:
	add_s r15,r15,r0
L_8d8024:
	mov_s r1,0x100fb38
L_8d802a:
	mov_s r0,0x2d
L_8d802c:
	mov_s r2,r13
L_8d802e:
	bl.d L_8dcc80
L_8d8032:
	mov_s r3,r13
L_8d8034:
	add3 r1,r14,0x30
L_8d8038:
	bl.d L_8e1ff0
L_8d803c:
	mov_s r0,r15
L_8d803e:
	mov_s r2,r0
L_8d8040:
	add_s r15,r15,r0
L_8d8042:
	add_s r13,r13,r0
L_8d8044:
	mov_s r1,0x100fb68
L_8d804a:
	mov_s r0,0x2d
L_8d804c:
	bl.d L_8dcc80
L_8d8050:
	mov_s r3,r13
L_8d8052:
	add1 r1,r14,0x2f
L_8d8056:
	mov_s r0,r15
L_8d8058:
	bl.d L_8e1fd4
L_8d805c:
	mov_s r2,0x0
L_8d805e:
	mov_s r2,r0
L_8d8060:
	add_s r13,r13,r0
L_8d8062:
	add_s r15,r15,r0
L_8d8064:
	mov_s r1,0x100fb98
L_8d806a:
	mov_s r0,0x2d
L_8d806c:
	bl.d L_8dcc80
L_8d8070:
	mov_s r3,r13
L_8d8072:
	mov_s r1,r14
L_8d8074:
	add r1,r1,0x11a
L_8d8078:
	ldb r2,[r14,0x17a]
L_8d8080:
	bl.d L_8e2048
L_8d8084:
	mov_s r0,r15
L_8d8086:
	mov_s r2,r0
L_8d8088:
	add_s r13,r13,r0
L_8d808a:
	add_s r15,r15,r0
L_8d808c:
	mov_s r1,0x100fbc8
L_8d8092:
	mov_s r0,0x2d
L_8d8094:
	bl.d L_8dcc80
L_8d8098:
	mov_s r3,r13
L_8d809a:
	add3 r1,r14,0x1f
L_8d809e:
	bl.d L_8e1fbc
L_8d80a2:
	mov_s r0,r15
L_8d80a4:
	mov_s r2,r0
L_8d80a6:
	add_s r13,r13,r0
L_8d80a8:
	add_s r15,r15,r0
L_8d80aa:
	mov_s r1,0x100fc00
L_8d80b0:
	mov_s r0,0x2d
L_8d80b2:
	bl.d L_8dcc80
L_8d80b6:
	mov_s r3,r13
L_8d80b8:
	mov_s r1,r14
L_8d80ba:
	add r1,r1,0x103
L_8d80be:
	bl.d L_8e1fa4
L_8d80c2:
	mov_s r0,r15
L_8d80c4:
	mov_s r2,r0
L_8d80c6:
	add_s r13,r13,r0
L_8d80c8:
	add_s r15,r15,r0
L_8d80ca:
	mov_s r1,0x100fc34
L_8d80d0:
	mov_s r0,0x2d
L_8d80d2:
	bl.d L_8dcc80
L_8d80d6:
	mov_s r3,r13
L_8d80d8:
	mov_s r0,r15
L_8d80da:
	bl.d L_8e1da8
L_8d80de:
	mov_s r1,r14
L_8d80e0:
	add_s r13,r13,r0
L_8d80e2:
	bl.d L_8e1f4c
L_8d80e6:
	add_s r0,r0,r15
L_8d80e8:
	add_s r0,r0,r13
L_8d80ea:
	extw_s r0,r0
L_8d80ec:
	b.d L_8c024c
L_8d80f0:
	add_s sp,sp,0x20
L_8d80f2:
	nop_s
