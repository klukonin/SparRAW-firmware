/* basic_if__alloc_evt_slot @ 0x921930, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   basic_if.cpp
 * Зовут его: tail_basic_if__alloc_evt_slot, uc_send_evt__bf_done, uc_send_evt__get_rf_sector_done, uc_send_evt__link_lost, uc_send_evt__mac_monitor, uc_send_evt__new_link, uc_send_evt__ps_awake_peer, uc_send_evt__ps_shallow_sleep_ntf, uc_send_evt__ps_wake_pcie, uc_send_evt__rs_done
 * Зовёт сам: uc_deref_field4_921990, uc_sysassert
 */
	.section .text.basic_if__alloc_evt_slot,"ax",@progbits
	.global basic_if__alloc_evt_slot
basic_if__alloc_evt_slot:
	.global L_921930
L_921930:
	st.a r13,[sp,-0xc]
L_921934:
	st blink,[sp, 0x4]
L_921938:
	st r14,[sp, 0x8]
L_92193c:
	lr r13,[0xa]
L_921940:
	bclr r2,r13,0x1
L_921944:
	flag r2
L_921948:
	bl.d L_921990
L_92194c:
	add r0,r0,0x4
L_921950:
	mov_s r14,r0
L_921952:
	lr r1,[0xa]
L_921956:
	bic r13,r13,-0x3
L_92195a:
	or_s r13,r13,r1
L_92195c:
	flag r13
L_921960:
	cmp r0,0x0
L_921964:
	bne.d L_921980
L_921968:
	add.ne r14,r14,0x10
L_92196c:
	mov_s r0,blink
L_92196e:
	mov_s r2,0x1001164
L_921974:
	mov r1,0xc1
L_921978:
	bl.d L_925548
L_92197c:
	mov r3,0x19
	.global L_921980
L_921980:
	ld blink,[sp, 0x4]
L_921984:
	mov_s r0,r14
L_921986:
	ld_s r14,[sp,0x8]
L_921988:
	j.d [blink]
L_92198c:
	ld.ab r13,[sp,0xc]
